/// Non-web stub: native builds cannot install a PWA.
library;

/// Whether the browser has offered an installable PWA prompt.
bool canInstallPwa() => false;

/// Triggers the browser install prompt. Returns the user's choice outcome
/// (`'accepted'`, `'dismissed'`) or `'unavailable'` when no prompt exists.
Future<String> promptPwaInstall() async => 'unavailable';
