/// Web implementation backed by the `brickclubPwa` shim in `web/index.html`.
library;

import 'dart:js_interop';

@JS('brickclubPwa.canInstall')
external bool _canInstall();

@JS('brickclubPwa.prompt')
external JSPromise<JSString> _prompt();

/// Whether the browser captured an installable PWA prompt.
bool canInstallPwa() => _canInstall();

/// Triggers the captured browser install prompt and resolves with the user's
/// choice outcome (`'accepted'`, `'dismissed'`) or `'unavailable'`.
Future<String> promptPwaInstall() async {
  final outcome = await _prompt().toDart;
  return outcome.toDart;
}
