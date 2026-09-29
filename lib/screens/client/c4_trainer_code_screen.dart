import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../data/models.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/back_circle_button.dart';
import '../../widgets/code_input_row.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';

/// C4 — fallback from C1b when the phone number isn't recognized.
/// The design has no error state of its own for a wrong code; reusing
/// the OTP screens' red-outline + message treatment for consistency
/// (flagged as an inferred behavior in the plan).
class C4TrainerCodeScreen extends StatefulWidget {
  const C4TrainerCodeScreen({
    super.key,
    required this.expectedCode,
    required this.trainer,
    required this.onContinue,
  });

  final String expectedCode;
  final TrainerMock trainer;
  final VoidCallback onContinue;

  @override
  State<C4TrainerCodeScreen> createState() => _C4TrainerCodeScreenState();
}

class _C4TrainerCodeScreenState extends State<C4TrainerCodeScreen> {
  bool _verified = false;
  bool _error = false;

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
                BackCircleButton(onTap: () => Navigator.of(context).pop()),
                const SizedBox(width: 11),
                const RoleChip(role: AppRole.client),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your trainer's code", style: AppText.headline(28, height: 1.1)),
                  const SizedBox(height: 10),
                  Text(
                    "Your trainer's code is in the message they sent you.",
                    style: AppText.body(14, height: 1.55, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),
                  CodeInputRow(
                    expectedCode: widget.expectedCode,
                    onSuccess: () => setState(() {
                      _verified = true;
                      _error = false;
                    }),
                    onError: () => setState(() => _error = true),
                  ),
                  if (_error) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: AppColors.coral, shape: BoxShape.circle),
                          child: Text('!', style: AppText.headline(12, weight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "That code didn't match. Try again?",
                            style: AppText.body(13, weight: FontWeight.w500, color: AppColors.errorText),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (_verified) ...[
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadii.cardMd),
                        boxShadow: AppShadows.card,
                        border: Border.all(color: AppColors.green, width: 2),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(color: AppColors.ink, shape: BoxShape.circle),
                            child: Text(
                              widget.trainer.initials,
                              style: AppText.headline(14, color: AppColors.yellow),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(color: AppColors.green, shape: BoxShape.circle),
                                      child: AppIcon.strokePath(
                                        AppIconPaths.check(),
                                        color: AppColors.white,
                                        size: 11,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    Text('Found ${widget.trainer.name}', style: AppText.headline(17)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${widget.trainer.city.toUpperCase()} · ${widget.trainer.clientCount} CLIENTS · CODE ${widget.trainer.code}',
                                  style: AppText.mono(10, weight: FontWeight.w500, color: AppColors.textFaint),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    PrimaryCtaButton(
                      label: 'Continue with ${widget.trainer.name.split(' ').first}',
                      onTap: widget.onContinue,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
