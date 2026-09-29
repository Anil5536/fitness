import 'package:flutter/material.dart';

import '../core/colors.dart';

/// Cream page background with content constrained to a mobile-proportioned
/// column, so the 390px-wide designed layouts don't stretch awkwardly on
/// a resizable desktop window or a wide browser viewport. This is NOT a
/// port of the design board's `IOSDevice` phone-frame chrome (no status
/// bar / dynamic island / home indicator) — real screens just fill the
/// real window.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Standard screen top padding, replacing the design's 54px which
/// compensated for the phone-frame mockup's status bar (not ported here).
const kScreenTopPad = 36.0;
