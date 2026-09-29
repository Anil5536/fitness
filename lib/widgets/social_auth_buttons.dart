import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/icons/app_icon.dart';
import '../core/icons/icon_paths.dart';
import '../core/radii.dart';
import '../core/shadows.dart';
import '../core/typography.dart';

/// Google + Apple "continue with" button pair. Cosmetic only — real
/// OAuth is out of scope for this click-through prototype.
class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                boxShadow: AppShadows.field,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(
                    size: 19,
                    layers: [
                      IconLayer.fill(AppIconPaths.googleBlue(), color: AppColors.googleBlue),
                      IconLayer.fill(AppIconPaths.googleGreen(), color: AppColors.googleGreen),
                      IconLayer.fill(AppIconPaths.googleYellow(), color: AppColors.googleYellow),
                      IconLayer.fill(AppIconPaths.googleRed(), color: AppColors.googleRed),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Text('Continue with Google', style: AppText.body(14, weight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        Material(
          color: AppColors.ink,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(
                    size: 19,
                    layers: [IconLayer.fill(AppIconPaths.apple(), color: AppColors.white)],
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Continue with Apple',
                    style: AppText.body(14, weight: FontWeight.w600, color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The "――― OR ―――" divider between phone entry and social buttons.
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: AppColors.dividerStrong)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'OR',
              style: AppText.eyebrow(size: 10, letterSpacingEm: 0.12),
            ),
          ),
          Expanded(child: Container(height: 1, color: AppColors.dividerStrong)),
        ],
      ),
    );
  }
}
