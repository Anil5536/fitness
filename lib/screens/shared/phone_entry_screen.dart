import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/logo_mark.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';
import '../../widgets/social_auth_buttons.dart';

enum PhoneHeaderVariant { wordmark, roleChip }

/// Shared by C1b (client) and T1 (trainer) — near-identical layout, but
/// the header composition genuinely differs (wordmark text vs a role
/// chip, not just a recolor), so it's a parameter rather than inferred
/// from [role].
class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({
    super.key,
    required this.role,
    required this.headerVariant,
    required this.headline,
    required this.subhead,
    required this.initialPhone,
    required this.onSendOtp,
    this.showFreeCaption = false,
    this.onTrainerCodeTap,
  });

  final AppRole role;
  final PhoneHeaderVariant headerVariant;
  final String headline;
  final String subhead;
  final String initialPhone;
  final ValueChanged<String> onSendOtp;
  final bool showFreeCaption;
  final VoidCallback? onTrainerCodeTap;

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  late final _controller = TextEditingController(text: widget.initialPhone);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, kScreenTopPad, 22, 0),
            child: Row(
              children: [
                const LogoMark(),
                const SizedBox(width: 11),
                if (widget.headerVariant == PhoneHeaderVariant.wordmark)
                  Text('routinely', style: AppText.headline(18, letterSpacingEm: -0.025))
                else
                  RoleChip(role: widget.role),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.headline, style: AppText.headline(30, height: 1.08)),
                  const SizedBox(height: 10),
                  Text(
                    widget.subhead,
                    style: AppText.body(14, height: 1.55, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadii.cardMd),
                      boxShadow: AppShadows.card,
                      border: Border.all(color: AppColors.ink, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PHONE NUMBER', style: AppText.eyebrow()),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('+91', style: AppText.mono(24, weight: FontWeight.w500, color: AppColors.textFaint)),
                            const SizedBox(width: 8),
                            Flexible(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]'))],
                                  style: AppText.mono(24, weight: FontWeight.w600),
                                  cursorColor: AppColors.ink,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    isCollapsed: true,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Container(width: 2, height: 26, color: AppColors.coral),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  PrimaryCtaButton(
                    label: 'Send OTP',
                    onTap: () => widget.onSendOtp(_controller.text),
                  ),
                  if (widget.showFreeCaption) ...[
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'FREE UP TO 5 ACTIVE CLIENTS',
                        style: AppText.mono(11, weight: FontWeight.w500, color: AppColors.green),
                      ),
                    ),
                  ],
                  const OrDivider(),
                  const SocialAuthButtons(),
                ],
              ),
            ),
          ),
          if (widget.onTrainerCodeTap != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 26, 32),
              child: Center(
                child: GestureDetector(
                  onTap: widget.onTrainerCodeTap,
                  child: Text(
                    'Have a 6-digit code from your trainer?',
                    textAlign: TextAlign.center,
                    style: AppText.body(13, weight: FontWeight.w600, color: AppColors.errorText),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
