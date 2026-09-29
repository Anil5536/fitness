import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../state/trainer_onboarding_session.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/progress_dots.dart';
import '../../widgets/role_chip.dart';

class T5HandleScreen extends StatefulWidget {
  const T5HandleScreen({super.key, required this.session, required this.onFinish});

  final TrainerOnboardingSession session;
  final VoidCallback onFinish;

  @override
  State<T5HandleScreen> createState() => _T5HandleScreenState();
}

class _T5HandleScreenState extends State<T5HandleScreen> {
  late final _handle = TextEditingController(text: widget.session.handle);
  bool _copied = false;

  @override
  void dispose() {
    _handle.dispose();
    super.dispose();
  }

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.session.trainerCode));
    if (!mounted) return;
    setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, kScreenTopPad, 22, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const RoleChip(role: AppRole.trainer),
                    const SizedBox(width: 10),
                    Text('3 OF 3', style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1)),
                  ],
                ),
                const SizedBox(height: 14),
                const ProgressDots(count: 3, activeCount: 3, onColor: AppColors.yellow),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your handle', style: AppText.headline(28, height: 1.1)),
                  const SizedBox(height: 10),
                  Text(
                    "This is the link you'll send to leads and clients.",
                    style: AppText.body(14, height: 1.55, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 20),
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
                        Text('HANDLE', style: AppText.eyebrow()),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _handle,
                                onChanged: (_) => setState(() {}),
                                style: AppText.mono(20, weight: FontWeight.w600),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              width: 22,
                              height: 22,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
                              child: AppIcon.strokePath(
                                AppIconPaths.check(),
                                color: AppColors.white,
                                size: 13,
                                strokeWidth: 3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        Text(
                          'ROUTINELYCRM.COM/${_handle.text.toUpperCase()} · AVAILABLE',
                          style: AppText.mono(12, weight: FontWeight.w500, color: AppColors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.ink,
                      borderRadius: BorderRadius.circular(AppRadii.cardLg),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -26,
                          top: -26,
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(colors: [Color(0x80F5CE47), Color(0x00F5CE47)]),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'YOUR TRAINER CODE',
                              style: AppText.eyebrow(size: 9, color: AppColors.tan, letterSpacingEm: 0.14),
                            ),
                            const SizedBox(height: 9),
                            Text(
                              widget.session.trainerCode,
                              style: AppText.mono(34, weight: FontWeight.w600, color: AppColors.yellow, letterSpacingEm: 0.12),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              'Share this with clients to connect.',
                              style: AppText.body(12, height: 1.5, color: AppColors.tan),
                            ),
                            const SizedBox(height: 13),
                            Material(
                              color: AppColors.yellow,
                              borderRadius: BorderRadius.circular(AppRadii.pill),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppRadii.pill),
                                onTap: _copyCode,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Text(
                                    _copied ? 'Copied!' : 'Copy code',
                                    style: AppText.body(12, weight: FontWeight.w600, color: AppColors.ink),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: PrimaryCtaButton(
              label: 'Finish',
              onTap: () {
                widget.session.handle = _handle.text;
                widget.onFinish();
              },
            ),
          ),
        ],
      ),
    );
  }
}
