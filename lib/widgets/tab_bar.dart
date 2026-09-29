import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/icons/app_icon.dart';
import '../core/icons/icon_paths.dart';
import '../core/radii.dart';
import '../core/typography.dart';
import 'role_chip.dart';

class _TabDef {
  const _TabDef(this.label, this.path);
  final String label;
  final Path Function() path;
}

const _trainerTabs = [
  _TabDef('Home', AppIconPaths.tabHome),
  _TabDef('Leads', AppIconPaths.tabLeads),
  _TabDef('Clients', AppIconPaths.tabClients),
  _TabDef('Plans', AppIconPaths.tabPlans),
];
const _clientTabs = [
  _TabDef('Today', AppIconPaths.tabToday),
  _TabDef('Plan', AppIconPaths.tabPlan),
  _TabDef('Progress', AppIconPaths.tabProgress),
  _TabDef('Profile', AppIconPaths.tabProfile),
];

/// Direct port of the design's `TabBar` component (html2.html). `set`
/// picks the trainer 5-tab set (Home/Leads/Clients/Plans/More — More
/// rendered separately as it uses dot icons, not a path) or the client
/// 4-tab set (Today/Plan/Progress/Profile).
class RoutinelyTabBar extends StatelessWidget {
  const RoutinelyTabBar({
    super.key,
    required this.role,
    required this.activeIndex,
    this.overdueCount = 0,
    this.onTap,
  });

  final AppRole role;
  final int activeIndex;
  final int overdueCount;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    final isTrainer = role == AppRole.trainer;
    final tabs = isTrainer ? _trainerTabs : _clientTabs;
    final count = tabs.length + (isTrainer ? 1 : 0); // trainer set adds "More"

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.divider, width: 1)),
        boxShadow: [
          BoxShadow(
            color: AppColors.ink.withValues(alpha: 0.05),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 10, 4, 30),
        child: Row(
          children: List.generate(count, (i) {
            final isMore = isTrainer && i == tabs.length;
            final on = i == activeIndex;
            final ink = on ? AppColors.ink : AppColors.textFaint;
            final leadsIndex = 1;
            final showBadge = isTrainer && i == leadsIndex && overdueCount > 0;

            return Expanded(
              child: InkWell(
                onTap: onTap == null ? null : () => onTap!(i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 44,
                      height: 30,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: on ? AppColors.yellow : Colors.transparent,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            isMore
                                ? AppIconDots(color: ink, size: 21)
                                : AppIcon.strokePath(
                                    tabs[i].path(),
                                    color: ink,
                                    size: 21,
                                    strokeWidth: 1.9,
                                  ),
                            if (showBadge)
                              Positioned(
                                top: -4,
                                right: 2,
                                child: Container(
                                  constraints: const BoxConstraints(minWidth: 17),
                                  height: 17,
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.coral,
                                    borderRadius: BorderRadius.circular(AppRadii.pill),
                                    border: Border.all(color: AppColors.white, width: 2),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '$overdueCount',
                                    style: AppText.mono(
                                      10,
                                      weight: FontWeight.w600,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      isMore ? 'More' : tabs[i].label,
                      style: AppText.body(10, weight: FontWeight.w500, color: ink),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
