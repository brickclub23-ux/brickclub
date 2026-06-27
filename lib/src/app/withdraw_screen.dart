part of 'brickclub_app.dart';

/// Member-facing withdrawal request. The member picks a rail, enters an amount
/// (validated against the admin minimum and their wallet balance), supplies a
/// destination wallet address and an optional QR image of it. Submitting only
/// queues the request — funds are debited when an admin approves it.
class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({
    super.key,
    required this.kyc,
    required this.investmentRepository,
    required this.data,
    this.availablePaymentMethods = const [],
  });

  final KycProfile kyc;
  final InvestmentRepository investmentRepository;
  final MemberDashboardData data;
  final List<String> availablePaymentMethods;

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  bool submitting = false;
  DepositProofFile? qrCode;
  late String selectedAsset;
  late final TextEditingController amountController;
  late final TextEditingController destinationController;

  @override
  void initState() {
    super.initState();
    selectedAsset = _withdrawAssets.contains('USDT')
        ? 'USDT'
        : _withdrawAssets.first;
    amountController = TextEditingController();
    destinationController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  List<String> get _withdrawAssets {
    final methods = widget.availablePaymentMethods
        .where((method) => method.toUpperCase() != 'USD WALLET')
        .map((method) => method.trim().toUpperCase())
        .where((method) => method.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return methods.isEmpty ? const ['USDT'] : methods;
  }

  double get _enteredAmount {
    final normalized = amountController.text.replaceAll(',', '').trim();
    return double.tryParse(normalized) ?? 0;
  }

  double get _minimum => widget.data.withdrawalMinimumUsd;
  double get _balance => widget.data.walletBalanceUsd;

  bool get _belowMinimum =>
      _enteredAmount > 0 && _enteredAmount < _minimum;
  bool get _exceedsBalance => _enteredAmount > _balance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final amount = _enteredAmount;
    final enabled = widget.data.withdrawalsEnabled;
    final addressFilled = destinationController.text.trim().isNotEmpty;
    final canSubmit = enabled &&
        widget.kyc.canPerformFinancialActions &&
        !submitting &&
        amount >= _minimum &&
        amount > 0 &&
        !_exceedsBalance &&
        addressFilled;

    return PhoneFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: detailAppBar(context, l10n.withdrawTitle),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              _FundingHero(
                title: l10n.withdrawTitle,
                location: l10n.withdrawSubtitle,
                amountText: _formatUsdExact(amount),
                rail: selectedAsset,
              ),
              SizedBox(height: 18),
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.withdrawAvailable, style: AppText.cardHeadingSmall),
                    SizedBox(height: 6),
                    Text(widget.data.walletBalanceText, style: AppText.walletValue),
                    SizedBox(height: 16),
                    FieldLabel(l10n.paymentRail),
                    SizedBox(height: 10),
                    FilterChoices(
                      values: _withdrawAssets,
                      selected: selectedAsset,
                      onChanged: (value) =>
                          setState(() => selectedAsset = value),
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.withdrawAmount),
                    SizedBox(height: 8),
                    AppTextField(
                      key: const ValueKey('withdraw-amount'),
                      controller: amountController,
                      hintText: l10n.withdrawAmountHint,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.payments_outlined,
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _exceedsBalance
                          ? l10n.withdrawExceedsBalance(
                              widget.data.walletBalanceText,
                            )
                          : l10n.withdrawMinimum(
                              widget.data.withdrawalMinimumText,
                            ),
                      style: _belowMinimum || _exceedsBalance
                          ? AppText.warning
                          : AppText.small,
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.withdrawDestinationAddress),
                    SizedBox(height: 8),
                    AppTextField(
                      key: const ValueKey('withdraw-address'),
                      controller: destinationController,
                      hintText: l10n.withdrawDestinationHint,
                      prefixIcon: Icons.account_balance_wallet_outlined,
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 16),
                    _PickerTile(
                      key: const ValueKey('withdraw-qr'),
                      icon: Icons.qr_code_2_rounded,
                      title: qrCode?.name ?? l10n.withdrawUploadQr,
                      onTap: _pickQr,
                    ),
                    SizedBox(height: 8),
                    Text(l10n.withdrawQrHelp, style: AppText.small),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.walletSettlementTitle,
                      style: AppText.cardHeadingSmall,
                    ),
                    SizedBox(height: 10),
                    Text(l10n.withdrawReviewNote, style: AppText.body),
                  ],
                ),
              ),
              if (!enabled) ...[
                SizedBox(height: 14),
                Text(l10n.withdrawDisabled, style: AppText.warning),
              ],
              SizedBox(height: 36),
              PrimaryButton(
                key: const ValueKey('submit-withdrawal'),
                label: submitting
                    ? l10n.commonSubmitting
                    : l10n.withdrawSubmit,
                onPressed: canSubmit ? _submit : null,
              ),
              SizedBox(height: 14),
              SecondaryButton(
                label: l10n.commonCancel,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickQr() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );
    final file = result?.files.single;
    if (file?.bytes == null) return;
    setState(() {
      qrCode = DepositProofFile(
        name: file!.name,
        bytes: file.bytes!,
        contentType: _contentTypeForName(file.name),
      );
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (destinationController.text.trim().isEmpty) {
      showMessage(context, l10n.withdrawEnterAddress);
      return;
    }
    setState(() => submitting = true);
    try {
      await widget.investmentRepository.createWithdrawalRequest(
        amountUsd: _enteredAmount,
        destinationAddress: destinationController.text,
        assetSymbol: selectedAsset,
        qrCode: qrCode,
      );
      if (mounted) {
        showMessage(context, l10n.withdrawSubmitted);
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) {
        showMessage(context, _friendlyUnexpectedMessage(error, l10n));
      }
    } finally {
      if (mounted) {
        setState(() => submitting = false);
      }
    }
  }
}
