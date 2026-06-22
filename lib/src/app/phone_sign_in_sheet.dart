part of 'brickclub_app.dart';

/// A two-step bottom-sheet: phone number → SMS OTP → signed in.
Future<void> showPhoneSignInSheet(
  BuildContext context, {
  required AuthRepository authRepository,
  required VoidCallback onSignedIn,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (_) => _PhoneSignInSheet(
      authRepository: authRepository,
      onSignedIn: onSignedIn,
    ),
  );
}

class _PhoneSignInSheet extends StatefulWidget {
  const _PhoneSignInSheet({
    required this.authRepository,
    required this.onSignedIn,
  });

  final AuthRepository authRepository;
  final VoidCallback onSignedIn;

  @override
  State<_PhoneSignInSheet> createState() => _PhoneSignInSheetState();
}

class _PhoneSignInSheetState extends State<_PhoneSignInSheet> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  bool _sendingCode = false;
  bool _confirmingCode = false;
  String? _verificationId;
  String? _errorMessage;

  bool get _inOtpStep => _verificationId != null && _verificationId != 'auto';

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 24 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _inOtpStep ? l10n.phoneOtpTitle : l10n.phoneTitle,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _inOtpStep
                ? l10n.phoneOtpSubtitle(_phoneController.text.trim())
                : l10n.phoneSubtitle,
            style: TextStyle(color: AppColors.secondary, fontSize: 14, height: 1.45),
          ),
          const SizedBox(height: 20),
          if (!_inOtpStep) ...[
            AppTextField(
              controller: _phoneController,
              hintText: l10n.phoneHint,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
              autofillHints: const [AutofillHints.telephoneNumber],
            ),
          ] else ...[
            AppTextField(
              controller: _codeController,
              hintText: l10n.phoneCodeHint,
              keyboardType: TextInputType.number,
              prefixIcon: Icons.sms_outlined,
            ),
          ],
          if (_errorMessage != null) ...[
            const SizedBox(height: 12),
            _AuthMessageBanner(message: _errorMessage!),
          ],
          const SizedBox(height: 18),
          if (!_inOtpStep)
            PrimaryButton(
              label: _sendingCode ? l10n.phoneSendingCode : l10n.phoneSendCode,
              onPressed: _sendingCode ? null : _sendCode,
            )
          else ...[
            PrimaryButton(
              label: _confirmingCode ? l10n.phoneVerifying : l10n.phoneConfirmCode,
              onPressed: _confirmingCode ? null : _confirmCode,
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: _sendingCode ? null : _resetToPhoneStep,
                child: Text(l10n.phoneUseDifferentNumber),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _sendCode() async {
    setState(() {
      _sendingCode = true;
      _errorMessage = null;
    });
    try {
      final id = await widget.authRepository.sendPhoneVerificationCode(
        _phoneController.text,
      );
      if (!mounted) return;
      // 'auto' means verificationCompleted fired on Android — already signed in.
      if (id == 'auto') {
        Navigator.of(context).pop();
        widget.onSignedIn();
        return;
      }
      setState(() => _verificationId = id);
    } on AuthValidationException catch (e) {
      if (mounted) setState(() => _errorMessage = e.message);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = _authErrorMessage(e));
    } finally {
      if (mounted) setState(() => _sendingCode = false);
    }
  }

  Future<void> _confirmCode() async {
    setState(() {
      _confirmingCode = true;
      _errorMessage = null;
    });
    try {
      await widget.authRepository.signInWithPhoneCode(
        verificationId: _verificationId!,
        smsCode: _codeController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      widget.onSignedIn();
    } on AuthValidationException catch (e) {
      if (mounted) setState(() => _errorMessage = e.message);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = _authErrorMessage(e));
    } finally {
      if (mounted) setState(() => _confirmingCode = false);
    }
  }

  void _resetToPhoneStep() {
    setState(() {
      _verificationId = null;
      _codeController.clear();
      _errorMessage = null;
    });
  }
}
