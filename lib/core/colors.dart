import 'package:flutter/material.dart';

/// Design tokens extracted from the "Routinely Auth Board" design.
abstract final class AppColors {
  static const bg = Color(0xFFE9E5DD);
  static const ink = Color(0xFF1A1B1E);

  /// Primary CTA color. Also doubles as the trainer role-chip color —
  /// there is no separate "trainer identity" color in the design.
  static const yellow = Color(0xFFF5CE47);

  /// Client role-chip / prefill-border color.
  static const tan = Color(0xFFC9BFAC);

  static const white = Colors.white;

  static const textMuted = Color(0xFF4A4B50);
  static const textFaint = Color(0xFF5E5F63);
  static const textPlaceholder = Color(0xFF6B6C70);

  /// Checkmark / "connected" / "done" green. NOT the same token as
  /// [greenBright] — the two are not interchangeable.
  static const green = Color(0xFF2F6E43);

  /// Client progress-dot "on" color and the "Veg" diet dot. A distinct,
  /// brighter green from [green].
  static const greenBright = Color(0xFF3E8E58);

  static const coral = Color(0xFFEE6D57);
  static const errorText = Color(0xFF9A3E2C);

  static const googleBlue = Color(0xFF4285F4);
  static const googleGreen = Color(0xFF34A853);
  static const googleYellow = Color(0xFFFBBC05);
  static const googleRed = Color(0xFFEA4335);

  static Color divider = ink.withValues(alpha: 0.12);
  static Color dividerStrong = ink.withValues(alpha: 0.14);
}
