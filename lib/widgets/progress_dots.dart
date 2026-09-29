import 'package:flutter/material.dart';

import '../core/colors.dart';

/// Segmented step-progress bar. Trainer flow uses yellow for the "on"
/// segments; client flow uses the brighter green token — these are
/// genuinely different tokens in the design, not a recolor of one.
class ProgressDots extends StatelessWidget {
  const ProgressDots({
    super.key,
    required this.count,
    required this.activeCount,
    required this.onColor,
  });

  final int count;
  final int activeCount;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final on = i < activeCount;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i == count - 1 ? 0 : 5),
            height: 6,
            decoration: BoxDecoration(
              color: on ? onColor : AppColors.ink.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
    );
  }
}
