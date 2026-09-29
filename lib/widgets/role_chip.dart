import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/radii.dart';
import '../core/typography.dart';

enum AppRole { trainer, client }

/// "TRAINER" / "CLIENT" role-identity pill. Trainer reuses the primary
/// CTA yellow (there's no separate trainer-identity color in the design);
/// client gets the distinct tan token.
class RoleChip extends StatelessWidget {
  const RoleChip({super.key, required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context) {
    final isTrainer = role == AppRole.trainer;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: isTrainer ? AppColors.yellow : AppColors.tan,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Text(
        isTrainer ? 'TRAINER' : 'CLIENT',
        style: AppText.eyebrow(
          size: 10,
          color: AppColors.ink,
          weight: FontWeight.w600,
          letterSpacingEm: 0.08,
        ),
      ),
    );
  }
}
