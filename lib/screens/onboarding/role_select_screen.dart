import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../routing/client_flow.dart';
import '../../routing/trainer_flow.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/logo_mark.dart';
import '../../widgets/primary_cta_button.dart';

enum RoleChoice { trainer, client }

/// S3 / S3b — "How will you use Routinely?" This is the app's real
/// entry point (replacing the earlier dev-only role picker): the
/// trainer card always keeps its yellow fill and the client card
/// always stays white — only the ink selection ring and the check/empty
/// circle move between them. The Continue label and destination follow
/// whichever card is selected.
class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen> {
  RoleChoice _choice = RoleChoice.trainer;

  void _continue() {
    if (_choice == RoleChoice.trainer) {
      TrainerFlow.start(context);
    } else {
      ClientFlow.start(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTrainer = _choice == RoleChoice.trainer;

    return AppShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, kScreenTopPad, 24, 0),
            child: Row(
              children: [
                const LogoMark(),
                const SizedBox(width: 11),
                Text('routinely', style: AppText.headline(18, letterSpacingEm: -0.025)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 26, 24, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How will you use Routinely?', style: AppText.headline(28, height: 1.15)),
                  const SizedBox(height: 10),
                  Text(
                    "Pick the one that's you — this sets up the whole app.",
                    style: AppText.body(14, height: 1.5, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),
                  _RoleOptionCard(
                    iconPath: AppIconPaths.tabClients(),
                    iconBg: AppColors.ink,
                    iconColor: AppColors.white,
                    background: AppColors.yellow,
                    title: "I'm a trainer",
                    subtitle: 'I coach clients and run my own business',
                    selected: isTrainer,
                    onTap: () => setState(() => _choice = RoleChoice.trainer),
                  ),
                  const SizedBox(height: 12),
                  _RoleOptionCard(
                    iconPath: AppIconPaths.tabPlan(),
                    iconBg: AppColors.bg,
                    iconColor: AppColors.textMuted,
                    background: AppColors.white,
                    title: 'I have a trainer',
                    subtitle: 'I follow a plan from my coach',
                    selected: !isTrainer,
                    onTap: () => setState(() => _choice = RoleChoice.client),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 14),
            child: PrimaryCtaButton(
              label: isTrainer ? 'Continue as trainer' : 'Continue as client',
              onTap: _continue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: AppText.body(13, color: AppColors.textMuted),
                  children: [
                    const TextSpan(text: 'Already have an account? '),
                    TextSpan(
                      text: 'Log in',
                      style: const TextStyle(color: AppColors.errorText, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleOptionCard extends StatelessWidget {
  const _RoleOptionCard({
    required this.iconPath,
    required this.iconBg,
    required this.iconColor,
    required this.background,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final Path iconPath;
  final Color iconBg;
  final Color iconColor;
  final Color background;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(AppRadii.cardLg),
          border: selected ? Border.all(color: AppColors.ink, width: 2.5) : null,
          boxShadow: selected ? null : AppShadows.softCard,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(14)),
              child: AppIcon.strokePath(iconPath, color: iconColor, size: 22, strokeWidth: 1.9),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppText.headline(17, letterSpacingEm: -0.01)),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: AppText.body(13, height: 1.35, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.ink : Colors.transparent,
                shape: BoxShape.circle,
                border: selected ? null : Border.all(color: AppColors.tan, width: 2),
              ),
              child: selected
                  ? AppIcon.strokePath(AppIconPaths.check(), color: AppColors.white, size: 12, strokeWidth: 3)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
