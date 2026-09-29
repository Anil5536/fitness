import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppShadows {
  /// Standard white-card shadow, e.g. bordered input cards.
  static List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.06),
      blurRadius: 22,
      offset: const Offset(0, 7),
    ),
  ];

  /// Lighter shadow for flat input/field cards and chips.
  static List<BoxShadow> field = [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.04),
      blurRadius: 14,
      offset: const Offset(0, 4),
    ),
  ];

  /// Slightly stronger flat shadow (social buttons, chips).
  static List<BoxShadow> raised = [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.05),
      blurRadius: 14,
      offset: const Offset(0, 4),
    ),
  ];

  /// Big soft shadow for large content cards on "done" screens.
  static List<BoxShadow> bigCard = [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.06),
      blurRadius: 26,
      offset: const Offset(0, 8),
    ),
  ];

  /// C5b selected-trainer-card double ring + shadow.
  static List<BoxShadow> selectionRing = [
    const BoxShadow(color: AppColors.bg, blurRadius: 0, spreadRadius: 3),
    const BoxShadow(color: AppColors.ink, blurRadius: 0, spreadRadius: 6),
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.1),
      blurRadius: 26,
      offset: const Offset(0, 8),
    ),
  ];

  /// Unselected trainer card shadow (C5b).
  static List<BoxShadow> softCard = [
    BoxShadow(
      color: AppColors.ink.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];
}
