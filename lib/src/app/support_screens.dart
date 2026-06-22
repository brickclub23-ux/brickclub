part of 'brickclub_app.dart';

/// Direct support channels shown on the support screen. The WhatsApp and
/// Telegram destinations open the official apps (or their web fallbacks).
const String supportWhatsAppNumber = '+1 (213) 397-5125';
const String supportTelegramHandle = '@xavarama';

// wa.me expects the number in international format with no spaces, plus, or
// punctuation; t.me expects the handle without the leading '@'.
const String _supportWhatsAppUrl = 'https://wa.me/12133975125';
const String _supportTelegramUrl = 'https://t.me/xavarama';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key, required this.repository});

  final SupportRepository repository;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: detailAppBar(context, l10n.profileSupport),
        body: StreamBuilder<List<SupportTicket>>(
          stream: repository.watchMyTickets(),
          builder: (context, snapshot) {
            final tickets = snapshot.data ?? const <SupportTicket>[];
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 26),
              children: [
                PrimaryButton(
                  key: const ValueKey('new-support-ticket'),
                  label: l10n.supportNewRequest,
                  onPressed: () => _showCreateTicket(context),
                ),
                SizedBox(height: 18),
                const _SupportContactCard(),
                SizedBox(height: 18),
                if (snapshot.connectionState == ConnectionState.waiting)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(color: AppColors.gold),
                    ),
                  )
                else if (tickets.isEmpty)
                  Panel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.supportNoRequestsTitle, style: AppText.h2),
                        SizedBox(height: 8),
                        Text(
                          l10n.supportNoRequestsBody,
                          style: AppText.body,
                        ),
                      ],
                    ),
                  )
                else
                  for (final ticket in tickets)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _SupportTicketTile(
                        ticket: ticket,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SupportThreadScreen(
                              repository: repository,
                              ticket: ticket,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCreateTicket(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _SupportComposerSheet(
        title: l10n.supportNewRequest,
        subjectEnabled: true,
        submitLabel: l10n.supportSendRequest,
        onSubmit: (subject, message) async {
          await repository.createTicket(subject: subject, message: message);
        },
      ),
    );
  }
}

class SupportThreadScreen extends StatelessWidget {
  const SupportThreadScreen({
    super.key,
    required this.repository,
    required this.ticket,
  });

  final SupportRepository repository;
  final SupportTicket ticket;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PhoneFrame(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: detailAppBar(context, ticket.subject),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 26),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(ticket.status.label, style: AppText.goldBody),
                ),
                Text(
                  l10n.supportMessagesCount(ticket.messages.length),
                  style: AppText.tiny,
                ),
              ],
            ),
            SizedBox(height: 16),
            for (final message in ticket.messages)
              _SupportMessageBubble(message: message),
            SizedBox(height: 16),
            PrimaryButton(
              key: const ValueKey('reply-support-ticket'),
              label: ticket.isClosed ? l10n.supportRequestClosed : l10n.supportReply,
              onPressed: ticket.isClosed ? null : () => _showReply(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showReply(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.panel,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _SupportComposerSheet(
        title: l10n.supportReplyTitle,
        subjectEnabled: false,
        submitLabel: l10n.supportSendReply,
        onSubmit: (_, message) async {
          await repository.replyToTicket(ticketId: ticket.id, message: message);
        },
      ),
    );
  }
}

class _SupportContactCard extends StatelessWidget {
  const _SupportContactCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Panel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.supportTalkDirectly, style: AppText.h2),
          SizedBox(height: 8),
          Text(
            l10n.supportTalkBody,
            style: AppText.body,
          ),
          SizedBox(height: 16),
          _SupportContactTile(
            key: const ValueKey('support-whatsapp'),
            icon: Icons.chat_rounded,
            channel: 'WhatsApp',
            detail: supportWhatsAppNumber,
            onTap: () => _openSupportChannel(context, _supportWhatsAppUrl),
          ),
          SizedBox(height: 12),
          _SupportContactTile(
            key: const ValueKey('support-telegram'),
            icon: Icons.send_rounded,
            channel: 'Telegram',
            detail: supportTelegramHandle,
            onTap: () => _openSupportChannel(context, _supportTelegramUrl),
          ),
        ],
      ),
    );
  }

  Future<void> _openSupportChannel(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched && context.mounted) {
      showMessage(context, AppLocalizations.of(context).supportCouldNotOpen(url));
    }
  }
}

class _SupportContactTile extends StatelessWidget {
  const _SupportContactTile({
    super.key,
    required this.icon,
    required this.channel,
    required this.detail,
    required this.onTap,
  });

  final IconData icon;
  final String channel;
  final String detail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.gold),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(channel, style: AppText.bodyLarge),
                    SizedBox(height: 2),
                    Text(detail, style: AppText.tinyLight),
                  ],
                ),
              ),
              Icon(Icons.open_in_new_rounded, color: AppColors.muted, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportTicketTile extends StatelessWidget {
  const _SupportTicketTile({required this.ticket, required this.onTap});

  final SupportTicket ticket;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.panel,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(ticket.subject, style: AppText.h2)),
                  Icon(Icons.chevron_right_rounded, color: AppColors.muted),
                ],
              ),
              SizedBox(height: 8),
              Text(
                ticket.latestMessage?.body ??
                    AppLocalizations.of(context).supportNoMessagesYet,
                style: AppText.body,
              ),
              SizedBox(height: 12),
              ChoicePill(label: ticket.status.label, selected: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _SupportMessageBubble extends StatelessWidget {
  const _SupportMessageBubble({required this.message});

  final SupportMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.isAdmin
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.end;
    final color = message.isAdmin ? AppColors.panel : AppColors.goldSoft;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            message.isAdmin
                ? AppLocalizations.of(context).supportTeamName
                : AppLocalizations.of(context).supportYou,
            style: AppText.tinyLight,
          ),
          SizedBox(height: 5),
          Container(
            constraints: const BoxConstraints(maxWidth: 290),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(message.body, style: AppText.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _SupportComposerSheet extends StatefulWidget {
  const _SupportComposerSheet({
    required this.title,
    required this.subjectEnabled,
    required this.submitLabel,
    required this.onSubmit,
  });

  final String title;
  final bool subjectEnabled;
  final String submitLabel;
  final Future<void> Function(String subject, String message) onSubmit;

  @override
  State<_SupportComposerSheet> createState() => _SupportComposerSheetState();
}

class _SupportComposerSheetState extends State<_SupportComposerSheet> {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  bool submitting = false;

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        22,
        22,
        22,
        MediaQuery.viewInsetsOf(context).bottom + 26,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: AppText.h2),
          if (widget.subjectEnabled) ...[
            SizedBox(height: 16),
            FieldLabel(l10n.supportSubject),
            SizedBox(height: 8),
            AppTextField(
              key: const ValueKey('support-subject'),
              controller: subjectController,
              hintText: l10n.supportSubjectHint,
              prefixIcon: Icons.support_agent_rounded,
            ),
          ],
          SizedBox(height: 16),
          FieldLabel(l10n.supportMessage),
          SizedBox(height: 8),
          TextField(
            key: const ValueKey('support-message'),
            controller: messageController,
            minLines: 4,
            maxLines: 6,
            style: TextStyle(fontSize: 14, color: AppColors.primary),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.surface,
              hintText: l10n.supportMessageHint,
              hintStyle: AppText.placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.gold, width: 1.3),
              ),
            ),
          ),
          SizedBox(height: 18),
          PrimaryButton(
            key: const ValueKey('send-support-message'),
            label: submitting ? l10n.commonSending : widget.submitLabel,
            onPressed: submitting ? null : _submit,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final subject = subjectController.text.trim();
    final message = messageController.text.trim();
    if (widget.subjectEnabled && subject.isEmpty) {
      showMessage(context, l10n.supportEnterSubject);
      return;
    }
    if (message.isEmpty) {
      showMessage(context, l10n.supportEnterMessage);
      return;
    }

    setState(() => submitting = true);
    try {
      await widget.onSubmit(subject, message);
      if (mounted) {
        Navigator.pop(context);
        showMessage(context, l10n.supportMessageSent);
      }
    } catch (error) {
      if (mounted) showMessage(context, _friendlyUnexpectedMessage(error));
    } finally {
      if (mounted) setState(() => submitting = false);
    }
  }
}

