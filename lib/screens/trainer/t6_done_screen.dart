import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';
import '../../widgets/tab_bar.dart';

class T6DoneScreen extends StatelessWidget {
  const T6DoneScreen({super.key, required this.handle, required this.onGoHome});

  final String handle;
  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: 130,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Color(0x99F5CE47), Color(0x00F5CE47)]),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
                        child: AppIcon.strokePath(
                          AppIconPaths.check(),
                          color: AppColors.white,
                          size: 30,
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Text('Your pipeline is ready.', style: AppText.headline(36, height: 1.05)),
                      const SizedBox(height: 12),
                      Text(
                        'Add your first lead, or share your form link and let them come to you.',
                        style: AppText.body(14, height: 1.6, color: AppColors.textMuted),
                      ),
                      const SizedBox(height: 26),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadii.cardLg),
                          boxShadow: AppShadows.bigCard,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOUR LINK',
                              style: AppText.eyebrow(size: 9, letterSpacingEm: 0.14),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              'routinelycrm.com/$handle',
                              style: AppText.mono(15, weight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: PrimaryCtaButton(label: 'Go to Home', onTap: onGoHome),
              ),
              const RoutinelyTabBar(role: AppRole.trainer, activeIndex: 0, overdueCount: 0),
            ],
          ),
        ],
      ),
    );
  }
}
