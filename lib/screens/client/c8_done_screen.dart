import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';
import '../../widgets/tab_bar.dart';

/// C8 — the static mockup hardcodes "Sneha" in its headline, but this
/// must be dynamic since C8 is reachable via paths where the client
/// typed a different name (empty-C6 via C4 or C5b).
class C8DoneScreen extends StatelessWidget {
  const C8DoneScreen({super.key, required this.firstName, required this.onGoHome});

  final String firstName;
  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    final name = firstName.trim().isEmpty ? 'there' : firstName.trim();
    return AppShell(
      child: Stack(
        children: [
          Positioned(
            right: -80,
            top: 140,
            child: Container(
              width: 270,
              height: 270,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Color(0xD9C9BFAC), Color(0x00C9BFAC)]),
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
                      Text("You're all set, $name.", style: AppText.headline(34, height: 1.06)),
                      const SizedBox(height: 12),
                      Text(
                        'Aarav has everything he needs. Your plan lands here as soon as he assigns it.',
                        style: AppText.body(14, height: 1.6, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
                child: PrimaryCtaButton(label: 'Go to Today', onTap: onGoHome),
              ),
              RoutinelyTabBar(role: AppRole.client, activeIndex: 0),
            ],
          ),
        ],
      ),
    );
  }
}
