import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/radii.dart';
import '../core/shadows.dart';
import '../core/typography.dart';

/// White (or tan-bordered, when [prefilledBadge] is set) rounded field
/// card: an eyebrow label above an editable value. Covers every "fld"
/// variant in the design (`fld`/`lbl`/`val`/`ph`, `fldPre`/`lblNo`/
/// `preRow`/`preChip`) as one widget rather than separate empty/prefilled
/// screens — see C6 vs C6b in the plan.
class LabeledFieldCard extends StatelessWidget {
  const LabeledFieldCard({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.mono = false,
    this.prefilledBadge,
    this.keyboardType,
    this.suffix,
    this.trailing,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final bool mono;
  final String? prefilledBadge;
  final TextInputType? keyboardType;
  final String? suffix;
  final Widget? trailing;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isPrefilled = prefilledBadge != null;
    final valueStyle = mono
        ? AppText.mono(isPrefilled ? 20 : 16, weight: FontWeight.w600)
        : AppText.body(isPrefilled ? 16 : 15, weight: FontWeight.w600);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.cardSm),
        boxShadow: AppShadows.field,
        border: isPrefilled
            ? Border.all(color: AppColors.tan.withValues(alpha: 0.9), width: 1.5)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.eyebrow()),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  readOnly: readOnly,
                  onTap: onTap,
                  keyboardType: keyboardType,
                  style: valueStyle,
                  cursorColor: AppColors.ink,
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: (mono
                            ? AppText.mono(15, weight: FontWeight.w500)
                            : AppText.body(15))
                        .copyWith(color: AppColors.textPlaceholder),
                  ),
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 6),
                Text(
                  suffix!,
                  style: AppText.body(13, color: AppColors.textFaint),
                ),
              ],
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
              if (prefilledBadge != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.tan,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                  ),
                  child: Text(
                    prefilledBadge!,
                    style: AppText.mono(
                      9,
                      weight: FontWeight.w600,
                      letterSpacingEm: 0.04,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
