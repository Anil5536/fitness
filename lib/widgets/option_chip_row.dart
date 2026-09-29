import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/radii.dart';
import '../core/shadows.dart';
import '../core/typography.dart';
import '../data/models.dart';

/// Wrapping row of selectable pill chips — gender, years-of-experience,
/// specialities, coaching mode. Selected: ink fill + yellow text.
/// Unselected: white fill + muted text + a light shadow.
class OptionChipRow<T> extends StatelessWidget {
  const OptionChipRow({
    super.key,
    required this.options,
    required this.labelOf,
    required this.isSelected,
    required this.onTap,
  });

  final List<T> options;
  final String Function(T) labelOf;
  final bool Function(T) isSelected;
  final ValueChanged<T> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: options.map((o) {
        final on = isSelected(o);
        return Material(
          color: on ? AppColors.ink : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadii.pill),
            onTap: () => onTap(o),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                boxShadow: on ? null : AppShadows.raised,
              ),
              child: Text(
                labelOf(o),
                style: AppText.body(
                  12,
                  weight: FontWeight.w600,
                  color: on ? AppColors.yellow : AppColors.textMuted,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// The diet segmented control (C7): one white pill container split into
/// equal-flex segments, each with a diet-colored dot that stays visible
/// regardless of selection, and ink+yellow fill on the selected segment.
class DietSegmentedControl extends StatelessWidget {
  const DietSegmentedControl({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final Diet selected;
  final ValueChanged<Diet> onChanged;

  static const _dotColor = {
    Diet.veg: AppColors.greenBright,
    Diet.egg: AppColors.yellow,
    Diet.nonVeg: AppColors.coral,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: AppShadows.raised,
      ),
      child: Row(
        children: Diet.values.map((d) {
          final on = d == selected;
          return Expanded(
            child: Material(
              color: on ? AppColors.ink : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                onTap: () => onChanged(d),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: _dotColor[d],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        d.label,
                        style: AppText.body(
                          12,
                          weight: FontWeight.w600,
                          color: on ? AppColors.yellow : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
