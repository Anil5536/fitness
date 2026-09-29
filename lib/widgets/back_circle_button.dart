import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/icons/app_icon.dart';
import '../core/icons/icon_paths.dart';
import '../core/shadows.dart';

/// White circular back button with the chevron icon, used on OTP and
/// trainer-code screens (the back arrow is part of the screen content
/// itself in the design, not a system nav bar).
class BackCircleButton extends StatelessWidget {
  const BackCircleButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap ?? () => Navigator.of(context).maybePop(),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: AppShadows.field,
          ),
          alignment: Alignment.center,
          child: AppIcon.strokePath(
            AppIconPaths.backChevron(),
            color: AppColors.ink,
            size: 16,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
