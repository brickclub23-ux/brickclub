part of 'brickclub_app.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.kyc,
    required this.opportunity,
    required this.investmentRepository,
  });

  final KycProfile kyc;
  final InvestmentOpportunity opportunity;
  final InvestmentRepository investmentRepository;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool submitting = false;
  PurchaseOrder? order;
  DepositProofFile? proof;
  late String selectedPaymentAsset;
  late final TextEditingController amountController;
  late final TextEditingController transactionHashController;

  @override
  void initState() {
    super.initState();
    selectedPaymentAsset = _cryptoPaymentMethods.contains('USDT')
        ? 'USDT'
        : _cryptoPaymentMethods.firstOrNull ?? 'USDT';
    amountController = TextEditingController(
      text: widget.opportunity.minimumInvestment.toStringAsFixed(0),
    );
    transactionHashController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    transactionHashController.dispose();
    super.dispose();
  }

  List<String> get _cryptoPaymentMethods {
    final methods =
        widget.opportunity.paymentMethods
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

  @override
  Widget build(BuildContext context) {
    final paymentMethods = _cryptoPaymentMethods;
    final amount = order?.amountUsd ?? _enteredAmount;
    final belowMinimum =
        order == null && amount < widget.opportunity.minimumInvestment;
    final l10n = AppLocalizations.of(context);
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: detailAppBar(context, l10n.paymentConfirmFunding),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              _FundingHero(
                title: widget.opportunity.displayTitle,
                location: widget.opportunity.location,
                amountText: _formatUsdCompact(amount),
                rail: selectedPaymentAsset,
              ),
              SizedBox(height: 18),
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            l10n.paymentSetup,
                            style: AppText.cardHeading,
                          ),
                        ),
                        _StatusChip(
                          order == null
                              ? l10n.paymentStatusDraft
                              : l10n.paymentStatusActive,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.paymentRail),
                    SizedBox(height: 10),
                    FilterChoices(
                      values: paymentMethods,
                      selected: selectedPaymentAsset,
                      onChanged: order == null
                          ? (value) => setState(() {
                              selectedPaymentAsset = value;
                            })
                          : (_) {},
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.paymentAmount),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: amountController,
                      hintText: l10n.paymentAmountHint,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.payments_outlined,
                      onChanged: (_) => setState(() {}),
                    ),
                    SizedBox(height: 8),
                    Text(
                      belowMinimum
                          ? l10n.paymentBelowMinimum(
                              widget.opportunity.minimumText,
                            )
                          : l10n.paymentDemoAmount,
                      style: belowMinimum ? AppText.warning : AppText.small,
                    ),
                    SizedBox(height: 18),
                    QuoteRow(
                      l10n.paymentQuotePaymentAsset,
                      order?.paymentAsset ?? selectedPaymentAsset,
                    ),
                    QuoteRow(l10n.paymentQuoteAmount, _formatUsdCompact(amount)),
                    QuoteRow(
                      l10n.paymentQuoteNetwork,
                      order == null
                          ? l10n.paymentNetworkAfterRequest
                          : order!.paymentNetwork,
                    ),
                    QuoteRow(
                      l10n.paymentQuote,
                      order == null
                          ? l10n.paymentQuoteByBackend
                          : order!.quoteText,
                    ),
                    QuoteRow(
                      l10n.paymentNetworkFee,
                      order == null
                          ? l10n.paymentFeeByBackend
                          : order!.networkFeeText,
                    ),
                    QuoteRow(
                      l10n.paymentSettlement,
                      l10n.paymentPendingConfirmation,
                      warning: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              _FundingSteps(order: order, proofReady: proof != null),
              if (order != null) ...[
                SizedBox(height: 18),
                _DepositInstructions(
                  order: order!,
                  proofName: proof?.name,
                  transactionHashController: transactionHashController,
                  onPickProof: _pickProof,
                ),
              ],
              SizedBox(height: 18),
              Panel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.paymentConfirmableTitle,
                      style: AppText.cardHeadingSmall,
                    ),
                    SizedBox(height: 10),
                    Text(
                      l10n.paymentConfirmableBody,
                      style: AppText.body,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 36),
              PrimaryButton(
                key: const ValueKey('confirm-purchase'),
                label: submitting
                    ? l10n.commonSubmitting
                    : order == null
                    ? l10n.paymentCreateRequest
                    : l10n.paymentSubmitProof,
                onPressed:
                    widget.kyc.canPerformFinancialActions &&
                        !submitting &&
                        !belowMinimum
                    ? () => order == null
                          ? _createDepositRequest(selectedPaymentAsset, amount)
                          : _submitProof()
                    : null,
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

  Future<void> _createDepositRequest(
    String paymentAsset,
    double amountUsd,
  ) async {
    final l10n = AppLocalizations.of(context);
    if (amountUsd < widget.opportunity.minimumInvestment) {
      showMessage(context, l10n.paymentIncreaseAmount);
      return;
    }
    setState(() => submitting = true);
    try {
      final createdOrder = await widget.investmentRepository
          .createPurchaseOrder(
            PurchaseRequest(
              opportunityId: widget.opportunity.id,
              amountUsd: amountUsd,
              paymentAsset: paymentAsset,
            ),
          );

      if (mounted) {
        setState(() => order = createdOrder);
        showMessage(context, l10n.paymentDepositCreated);
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

  Future<void> _pickProof() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    final file = result?.files.single;
    if (file?.bytes == null) return;
    setState(() {
      proof = DepositProofFile(
        name: file!.name,
        bytes: file.bytes!,
        contentType: _contentTypeForName(file.name),
      );
    });
  }

  Future<void> _submitProof() async {
    final currentOrder = order;
    final currentProof = proof;
    if (currentOrder == null) return;
    final l10n = AppLocalizations.of(context);
    if (transactionHashController.text.trim().isEmpty) {
      showMessage(context, l10n.paymentEnterHash);
      return;
    }
    if (currentProof == null) {
      showMessage(context, l10n.paymentUploadProof);
      return;
    }

    setState(() => submitting = true);
    try {
      final updatedOrder = await widget.investmentRepository.submitDepositProof(
        orderId: currentOrder.id,
        transactionHash: transactionHashController.text,
        proof: currentProof,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SuccessScreen(order: updatedOrder)),
        );
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

class _DepositInstructions extends StatelessWidget {
  const _DepositInstructions({
    required this.order,
    required this.proofName,
    required this.transactionHashController,
    required this.onPickProof,
  });

  final PurchaseOrder order;
  final String? proofName;
  final TextEditingController transactionHashController;
  final VoidCallback onPickProof;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.paymentDepositInstructions, style: AppText.cardHeading),
          SizedBox(height: 14),
          if (order.paymentQrCodeUrl.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                order.paymentQrCodeUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 14),
          ],
          _CopyableQuoteRow(
            l10n.paymentWalletAddress,
            order.paymentWalletAddress,
          ),
          QuoteRow(l10n.paymentQuoteNetwork, order.paymentNetwork),
          SizedBox(height: 14),
          FieldLabel(l10n.paymentTransactionHash),
          SizedBox(height: 8),
          AppTextField(
            key: const ValueKey('transaction-hash'),
            controller: transactionHashController,
            hintText: l10n.paymentHashHint,
            prefixIcon: Icons.tag_rounded,
          ),
          SizedBox(height: 14),
          _PickerTile(
            key: const ValueKey('payment-proof'),
            icon: Icons.upload_file_rounded,
            title: proofName ?? l10n.paymentUploadProof,
            onTap: onPickProof,
          ),
        ],
      ),
    );
  }
}

class _FundingHero extends StatelessWidget {
  const _FundingHero({
    required this.title,
    required this.location,
    required this.amountText,
    required this.rail,
  });

  final String title;
  final String location;
  final String amountText;
  final String rail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF087F7A),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF20BBAE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.currency_bitcoin_rounded,
                color: AppColors.primary,
                size: 22,
              ),
              SizedBox(width: 8),
              Text(rail, style: AppText.cardHeadingSmall),
              const Spacer(),
              Icon(Icons.north_east_rounded, color: AppColors.primary),
            ],
          ),
          SizedBox(height: 26),
          Text(amountText, style: AppText.walletValue),
          SizedBox(height: 6),
          Text(title, style: AppText.cardHeadingSmall),
          Text(location, style: AppText.bodyLarge),
        ],
      ),
    );
  }
}

class _FundingSteps extends StatelessWidget {
  const _FundingSteps({required this.order, required this.proofReady});

  final PurchaseOrder? order;
  final bool proofReady;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Panel(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: _FundingStep(
              icon: Icons.tune_rounded,
              label: l10n.paymentStepQuote,
              active: true,
              done: order != null,
            ),
          ),
          const _StepDivider(),
          Expanded(
            child: _FundingStep(
              icon: Icons.account_balance_wallet_outlined,
              label: l10n.paymentStepSend,
              active: order != null,
              done: proofReady,
            ),
          ),
          const _StepDivider(),
          Expanded(
            child: _FundingStep(
              icon: Icons.verified_outlined,
              label: l10n.paymentStepReview,
              active: proofReady,
              done: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _FundingStep extends StatelessWidget {
  const _FundingStep({
    required this.icon,
    required this.label,
    required this.active,
    required this.done,
  });

  final IconData icon;
  final String label;
  final bool active;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final color = done
        ? AppColors.success
        : active
        ? AppColors.gold
        : AppColors.muted;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .14),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: .45)),
          ),
          child: Icon(icon, color: color, size: 19),
        ),
        SizedBox(height: 7),
        Text(label, style: AppText.tinyLight, maxLines: 1),
      ],
    );
  }
}

class _StepDivider extends StatelessWidget {
  const _StepDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 1,
      margin: const EdgeInsets.only(bottom: 22),
      color: AppColors.border,
    );
  }
}

class _CopyableQuoteRow extends StatelessWidget {
  const _CopyableQuoteRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(child: Text(label, style: AppText.body)),
          Flexible(
            child: Text(
              _shortHash(value),
              textAlign: TextAlign.right,
              style: AppText.fieldLabel,
            ),
          ),
          IconButton(
            tooltip: l10n.paymentCopy,
            visualDensity: VisualDensity.compact,
            onPressed: value.trim().isEmpty
                ? null
                : () async {
                    await Clipboard.setData(ClipboardData(text: value));
                    if (context.mounted) {
                      showMessage(context, l10n.paymentWalletCopied);
                    }
                  },
            icon: Icon(Icons.copy_rounded, size: 16),
          ),
        ],
      ),
    );
  }
}

