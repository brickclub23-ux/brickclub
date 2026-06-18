/// Cross-platform facade for triggering a Progressive Web App install.
///
/// On the web the implementation talks to a small JavaScript shim defined in
/// `web/index.html` that captures the browser's `beforeinstallprompt` event.
/// On every other platform the stub reports that installation is unavailable.
library;

export 'pwa_install_stub.dart'
    if (dart.library.js_interop) 'pwa_install_web.dart';
