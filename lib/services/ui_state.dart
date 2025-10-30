import 'package:flutter/foundation.dart';

/// Global UI state controllers shared across the app.
/// Minimal surface: avoid external dependencies; use ValueNotifiers.
class GlobalUiState {
  // Controls whether the mobile floating nav should be hidden.
  // Set to true while a full-screen sheet/overlay is open.
  static final ValueNotifier<bool> examenSheetOpen = ValueNotifier<bool>(false);
}
