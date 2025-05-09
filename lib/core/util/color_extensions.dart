import 'package:flutter/material.dart';

/// DEPRECATED: This file is kept for backward compatibility.
/// All uses of withAlphaValue() should be replaced with the built-in withOpacity() method.
/// This file can be safely removed once all references have been updated.
extension ColorExtensions on Color {
  // Deprecated - use built-in withOpacity instead

  Color withAlphaValue(double opacity) => withValues();
}
