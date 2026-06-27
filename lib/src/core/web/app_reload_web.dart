/// Web implementation: reloads the browser document.
library;

import 'dart:js_interop';

@JS('window.location.reload')
external void _reload();

/// Hard-reloads the browser document and returns `true`. This re-runs the whole
/// app from scratch, which is the surest way to recover after a network drop.
bool reloadApp() {
  _reload();
  return true;
}
