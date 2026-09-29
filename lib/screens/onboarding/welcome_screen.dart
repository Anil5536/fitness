import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/logo_mark.dart';
import '../../widgets/primary_cta_button.dart';
import 'role_select_screen.dart';

/// S2 — "Your coaching business, in one place." "I already have an
/// account" has no destination in the design (no login flow exists
/// yet), so it's inert here, same treatment as S3's "Log in".
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                gradient: RadialGradient(colors: [Color(0xD9C9BFAC), Color(0x00C9BFAC)]),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24, kScreenTopPad, 24, 0),
                child: LogoMark(size: 30),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your coaching business, in one place', style: AppText.headline(32, height: 1.1)),
                    const SizedBox(height: 12),
                    Text(
                      'Leads, clients, plans and payments — without the spreadsheet and twelve WhatsApp threads.',
                      style: AppText.body(14, height: 1.55, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: PrimaryCtaButton(
                  label: 'Get started',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RoleSelectScreen()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28),
                child: Center(
                  child: Text(
                    'I already have an account',
                    style: AppText.body(13, weight: FontWeight.w500, color: AppColors.textMuted),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
