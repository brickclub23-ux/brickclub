/// Cross-platform facade for hard-reloading the running app.
///
/// On the web this reloads the browser document (the most reliable way to
/// recover from a transient network failure that left the page in a bad
/// state). On every other platform there is no document to reload, so the stub
/// reports that a hard reload was not performed and callers fall back to
/// re-fetching their data in place.
library;

export 'app_reload_stub.dart'
    if (dart.library.js_interop) 'app_reload_web.dart';
