import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../data/models.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';

/// C5b — shown only when the verified number has pending invites from
/// more than one trainer. Note the selection indicator here is a plain
/// filled/outlined circle, not the checkmark icon used everywhere else
/// for "confirmed" states (see plan gotcha).
class C5bConnectedMultipleScreen extends StatefulWidget {
  const C5bConnectedMultipleScreen({
    super.key,
    required this.trainers,
    required this.onContinue,
  });

  final List<TrainerMock> trainers;
  final ValueChanged<TrainerMock> onContinue;

  @override
  State<C5bConnectedMultipleScreen> createState() => _C5bConnectedMultipleScreenState();
}

class _C5bConnectedMultipleScreenState extends State<C5bConnectedMultipleScreen> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, kScreenTopPad, 24, 0),
            child: Row(children: [RoleChip(role: AppRole.client)]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Who's your trainer?", style: AppText.headline(32, height: 1.06)),
                  const SizedBox(height: 10),
                  Text(
                    "Two trainers have you on their list. Pick the one you're training with.",
                    style: AppText.body(14, height: 1.55, color: AppColors.textMuted),
                  ),
                  ...List.generate(widget.trainers.length, (i) {
                    final t = widget.trainers[i];
                    final on = i == _selected;
                    return Padding(
                      padding: EdgeInsets.only(top: on ? 24 : 10),
                      child: GestureDetector(
                        onTap: () => setState(() => _selected = i),
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppRadii.cardLg),
                            boxShadow: on ? AppShadows.selectionRing : AppShadows.softCard,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: on ? AppColors.ink : AppColors.tan,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  t.initials,
                                  style: AppText.headline(15, color: on ? AppColors.yellow : AppColors.ink),
                                ),
                              ),
                              const SizedBox(width: 13),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(t.name, style: AppText.headline(18, letterSpacingEm: -0.02)),
                                    const SizedBox(height: 4),
                                    Text(
                                      t.handle,
                                      style: AppText.mono(11, weight: FontWeight.w500, color: AppColors.textFaint),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: on ? AppColors.green : null,
                                  shape: BoxShape.circle,
                                  border: on ? null : Border.all(color: AppColors.tan, width: 2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 34),
            child: PrimaryCtaButton(
              label: 'Continue',
              onTap: () => widget.onContinue(widget.trainers[_selected]),
            ),
          ),
        ],
      ),
    );
  }
}
