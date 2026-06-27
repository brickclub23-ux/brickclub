/// Non-web stub: native builds have no document to hard-reload.
library;

/// Attempts a hard reload of the app. Always `false` off the web, signalling the
/// caller to refresh its data in place instead.
bool reloadApp() => false;
