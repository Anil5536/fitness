import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/radii.dart';
import '../core/typography.dart';

/// The yellow pill CTA used for every primary action ("Send OTP", "Next",
/// "Finish", "Continue", ...). [dark] gives the ink-filled variant used
/// for a couple of secondary-but-prominent actions (e.g. the Apple button).
class PrimaryCtaButton extends StatelessWidget {
  const PrimaryCtaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.dark = false,
    this.leading,
  });

  final String label;
  final VoidCallback? onTap;
  final bool dark;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? AppColors.ink : AppColors.yellow,
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 8)],
              Text(
                label,
                style: AppText.headline(
                  15,
                  weight: FontWeight.w700,
                  color: dark ? AppColors.white : AppColors.ink,
                  letterSpacingEm: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A flat white pill button — "Add photo", "Resend code", social buttons.
class SecondaryPillButton extends StatelessWidget {
  const SecondaryPillButton({
    super.key,
    required this.label,
    required this.onTap,
    this.leading,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 10)],
              Text(label, style: AppText.body(14, weight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
