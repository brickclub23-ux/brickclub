part of 'brickclub_app.dart';

class KycStatusCard extends StatelessWidget {
  const KycStatusCard({
    super.key,
    required this.kyc,
    required this.onStartKyc,
    this.compact = false,
    this.showAction = true,
  });

  final KycProfile kyc;
  final VoidCallback onStartKyc;
  final bool compact;
  final bool showAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isApproved = kyc.status == KycStatus.approved;
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isApproved
                    ? Icons.verified_rounded
                    : Icons.verified_user_outlined,
                color: isApproved ? AppColors.success : AppColors.gold,
                size: 30,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('KYC ${kyc.label}', style: AppText.cardHeadingSmall),
                    SizedBox(height: 4),
                    Text(_statusCopy(l10n, kyc), style: AppText.body),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          ProgressLine(value: kyc.completionRatio.clamp(0, 1), height: 6),
          if (!compact) ...[
            SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _KycChip(l10n.commonEmail, kyc.emailVerified),
                _KycChip(l10n.kycChipPhone, kyc.phoneVerified),
                _KycChip(l10n.kycChipIdentity, kyc.status == KycStatus.approved),
              ],
            ),
          ],
          if (showAction) ...[
            SizedBox(height: 16),
            PrimaryButton(
              key: const ValueKey('kyc-status-cta'),
              label: isApproved ? l10n.kycViewDetails : l10n.kycGateComplete,
              height: 44,
              onPressed: onStartKyc,
            ),
          ],
        ],
      ),
    );
  }

  String _statusCopy(AppLocalizations l10n, KycProfile kyc) {
    return switch (kyc.status) {
      KycStatus.approved => l10n.kycStatusApproved,
      KycStatus.submitted => l10n.kycStatusSubmitted,
      KycStatus.rejected =>
        kyc.rejectionReason ?? l10n.kycStatusRejectedDefault,
      _ => l10n.kycStatusDefault,
    };
  }
}

class _KycChip extends StatelessWidget {
  const _KycChip(this.label, this.complete);

  final String label;
  final bool complete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ChoicePill(
      label: '$label ${complete ? l10n.kycChipOk : l10n.kycChipNeeded}',
      selected: complete,
    );
  }
}

class KycScreen extends StatefulWidget {
  const KycScreen({super.key, required this.repository});

  final KycRepository repository;

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneCodeController = TextEditingController();
  final imagePicker = ImagePicker();
  DateTime? dateOfBirth;
  KycDocumentFile? governmentId;
  KycDocumentFile? selfie;
  KycDocumentFile? addressProof;
  bool sendingEmail = false;
  bool sendingPhone = false;
  bool submitting = false;
  String? kycMessage;

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    phoneCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: detailAppBar(context, l10n.kycVerifyIdentity),
        body: StreamBuilder<KycProfile>(
          stream: widget.repository.watchProfile(),
          builder: (context, snapshot) {
            final kyc =
                snapshot.data ??
                const KycProfile(
                  status: KycStatus.notStarted,
                  emailVerified: false,
                  phoneVerified: false,
                );
            _hydrateOnce(kyc);
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KycStatusCard(
                      kyc: kyc,
                      onStartKyc: () {},
                      compact: true,
                      showAction: false,
                    ),
                    if (kycMessage != null) ...[
                      SizedBox(height: 14),
                      _KycMessageBanner(message: kycMessage!),
                    ],
                    SizedBox(height: 18),
                    FieldLabel(l10n.kycFullName),
                    SizedBox(height: 8),
                    AppTextField(
                      controller: fullNameController,
                      hintText: l10n.kycFullNameHint,
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycDob),
                    SizedBox(height: 8),
                    _PickerTile(
                      key: const ValueKey('kyc-dob'),
                      icon: Icons.calendar_month_outlined,
                      title: dateOfBirth == null
                          ? l10n.kycSelectDate
                          : DateFormat.yMMMd().format(dateOfBirth!),
                      onTap: _pickDateOfBirth,
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycGovId),
                    SizedBox(height: 8),
                    _PickerTile(
                      key: const ValueKey('kyc-government-id'),
                      icon: Icons.badge_outlined,
                      title: governmentId?.name ?? l10n.kycUploadId,
                      onTap: () => _pickFile((file) => governmentId = file),
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycSelfie),
                    SizedBox(height: 8),
                    _PickerTile(
                      key: const ValueKey('kyc-selfie'),
                      icon: Icons.face_retouching_natural_outlined,
                      title: selfie?.name ?? l10n.kycCaptureSelfie,
                      onTap: _pickSelfie,
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycAddressProof),
                    SizedBox(height: 8),
                    _PickerTile(
                      key: const ValueKey('kyc-address-proof'),
                      icon: Icons.home_work_outlined,
                      title: addressProof?.name ?? l10n.kycUploadAddress,
                      onTap: () => _pickFile((file) => addressProof = file),
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycPhoneVerification),
                    SizedBox(height: 8),
                    AppTextField(
                      key: const ValueKey('kyc-phone'),
                      controller: phoneController,
                      hintText: '+12025550190',
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_iphone_rounded,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.telephoneNumber],
                    ),
                    SizedBox(height: 10),
                    SecondaryButton(
                      key: const ValueKey('send-phone-code'),
                      label: sendingPhone ? l10n.commonSending : l10n.kycSendCode,
                      onPressed: sendingPhone ? null : _sendPhoneCode,
                    ),
                    SizedBox(height: 10),
                    AppTextField(
                      key: const ValueKey('kyc-phone-code'),
                      controller: phoneCodeController,
                      hintText: l10n.kycVerificationCodeHint,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.sms_outlined,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 16),
                    FieldLabel(l10n.kycEmailVerification),
                    SizedBox(height: 8),
                    _VerificationRow(
                      label: kyc.emailVerified
                          ? l10n.kycEmailVerified
                          : l10n.kycEmailNotVerified,
                      verified: kyc.emailVerified,
                      action: sendingEmail ? l10n.commonSending : l10n.kycSendEmail,
                      onAction: sendingEmail || kyc.emailVerified
                          ? null
                          : _sendEmailVerification,
                    ),
                    SizedBox(height: 26),
                    PrimaryButton(
                      key: const ValueKey('submit-kyc'),
                      label: submitting
                          ? l10n.commonSubmitting
                          : l10n.kycSubmitForReview,
                      onPressed: submitting ? null : _submit,
                    ),
                    SizedBox(height: 10),
                    Text(
                      l10n.kycEmulatorNote,
                      style: AppText.disclosure,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  var hydrated = false;

  void _hydrateOnce(KycProfile kyc) {
    if (hydrated) return;
    fullNameController.text = kyc.fullLegalName ?? fullNameController.text;
    phoneController.text = kyc.phoneNumber ?? phoneController.text;
    dateOfBirth = kyc.dateOfBirth;
    hydrated = true;
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: dateOfBirth ?? DateTime(now.year - 25),
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year - 18, now.month, now.day),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: AppColors.gold,
            surface: AppColors.panel,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => dateOfBirth = picked);
    }
  }

  Future<void> _pickFile(ValueChanged<KycDocumentFile> onPicked) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      withData: true,
    );
    final file = result?.files.single;
    if (file?.bytes == null) return;
    setState(() {
      onPicked(
        KycDocumentFile(
          name: file!.name,
          bytes: file.bytes!,
          contentType: _contentTypeFor(file.name),
        ),
      );
    });
  }

  Future<void> _pickSelfie() async {
    final source = kIsWeb ? ImageSource.gallery : ImageSource.camera;
    final image = await imagePicker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 84,
    );
    if (image == null) return;
    final bytes = await image.readAsBytes();
    setState(() {
      selfie = KycDocumentFile(
        name: image.name,
        bytes: bytes,
        contentType: image.mimeType ?? _contentTypeFor(image.name),
      );
    });
  }

  Future<void> _sendEmailVerification() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      kycMessage = null;
      sendingEmail = true;
    });
    try {
      await widget.repository.sendEmailVerification();
      if (mounted) {
        showMessage(context, l10n.kycEmailSent);
      }
    } catch (error) {
      if (mounted) _showKycMessage(_kycErrorMessage(l10n, error));
    } finally {
      if (mounted) setState(() => sendingEmail = false);
    }
  }

  Future<void> _sendPhoneCode() async {
    final l10n = AppLocalizations.of(context);
    if (phoneController.text.trim().isEmpty) {
      _showKycMessage(l10n.kycEnterPhoneFirst);
      return;
    }
    setState(() {
      kycMessage = null;
      sendingPhone = true;
    });
    try {
      await widget.repository.sendPhoneVerificationCode(phoneController.text);
      if (mounted) {
        showMessage(context, l10n.kycCodeSent);
      }
    } catch (error) {
      if (mounted) _showKycMessage(_kycErrorMessage(l10n, error));
    } finally {
      if (mounted) setState(() => sendingPhone = false);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final missing = _missingFields(l10n);
    if (missing != null) {
      _showKycMessage(missing);
      return;
    }

    setState(() {
      kycMessage = null;
      submitting = true;
    });
    try {
      await widget.repository.submit(
        KycSubmission(
          fullLegalName: fullNameController.text,
          dateOfBirth: dateOfBirth!,
          phoneNumber: phoneController.text,
          phoneVerificationCode: phoneCodeController.text,
          governmentId: governmentId!,
          selfie: selfie!,
          addressProof: addressProof!,
        ),
      );
      if (mounted) {
        showMessage(context, l10n.kycSubmitted);
        Navigator.pop(context);
      }
    } catch (error) {
      if (mounted) _showKycMessage(_kycErrorMessage(l10n, error));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }

  String? _missingFields(AppLocalizations l10n) {
    if (fullNameController.text.trim().isEmpty) return l10n.kycMissingName;
    if (dateOfBirth == null) return l10n.kycMissingDob;
    if (governmentId == null) return l10n.kycMissingId;
    if (selfie == null) return l10n.kycMissingSelfie;
    if (addressProof == null) return l10n.kycMissingAddress;
    if (phoneController.text.trim().isEmpty) return l10n.kycMissingPhone;
    if (!_isE164PhoneNumber(phoneController.text.trim())) {
      return l10n.kycInvalidPhone;
    }
    if (phoneCodeController.text.trim().isEmpty) {
      return l10n.kycMissingCode;
    }
    return null;
  }

  void _showKycMessage(String message) {
    final displayMessage = message.trim().isEmpty
        ? AppLocalizations.of(context).kycUpdateFailed
        : message.trim();
    setState(() => kycMessage = displayMessage);
    showMessage(context, displayMessage);
  }

  bool _isE164PhoneNumber(String phoneNumber) {
    return RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(phoneNumber);
  }

  String _contentTypeFor(String name) {
    final lower = name.toLowerCase();
    if (lower.endsWith('.pdf')) return 'application/pdf';
    if (lower.endsWith('.png')) return 'image/png';
    return 'image/jpeg';
  }
}

class _KycMessageBanner extends StatelessWidget {
  const _KycMessageBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Container(
        key: const ValueKey('kyc-message'),
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.panel,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.warning.withValues(alpha: .55)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.warning,
              size: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.gold, size: 20),
            SizedBox(width: 12),
            Expanded(child: Text(title, style: AppText.fieldLabel)),
            Icon(Icons.chevron_right_rounded, color: AppColors.muted),
          ],
        ),
      ),
    );
  }
}

class _VerificationRow extends StatelessWidget {
  const _VerificationRow({
    required this.label,
    required this.verified,
    required this.action,
    required this.onAction,
  });

  final String label;
  final bool verified;
  final String action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Panel(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(
            verified ? Icons.check_circle_rounded : Icons.mail_outline_rounded,
            color: verified ? AppColors.success : AppColors.gold,
          ),
          SizedBox(width: 12),
          Expanded(child: Text(label, style: AppText.fieldLabel)),
          SizedBox(
            width: 104,
            child: SecondaryButton(
              label: action,
              onPressed: onAction,
              compact: true,
            ),
          ),
        ],
      ),
    );
  }
}

String _kycErrorMessage(AppLocalizations l10n, Object error) {
  if (error is KycValidationException) {
    return error.message;
  }
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'invalid-phone-number' => l10n.kycInvalidPhone,
      'invalid-verification-code' => l10n.errKycInvalidCode,
      'credential-already-in-use' => l10n.errKycCredentialInUse,
      'too-many-requests' => l10n.errKycTooManyRequests,
      _ =>
        error.message?.trim().isNotEmpty == true
            ? error.message!
            : l10n.errKycPhoneFailed,
    };
  }
  if (error is FirebaseException) {
    return switch (error.code) {
      'unauthenticated' => l10n.errKycSignInAgain,
      'permission-denied' => l10n.errKycNoPermission,
      'unavailable' => l10n.errKycUnavailable,
      'deadline-exceeded' => l10n.errKycDeadline,
      'storage/unauthorized' => l10n.errKycStorageUnauthorized,
      'storage/canceled' => l10n.errKycStorageCanceled,
      'storage/retry-limit-exceeded' => l10n.errKycStorageRetry,
      'storage/quota-exceeded' => l10n.errKycStorageQuota,
      _ => l10n.kycUpdateFailed,
    };
  }
  return _friendlyUnexpectedMessage(error, l10n);
}

