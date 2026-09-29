import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../state/trainer_onboarding_session.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/option_chip_row.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/progress_dots.dart';
import '../../widgets/role_chip.dart';

/// T4 — "Skip for now" behaves identically to "Next" (fields are
/// already prefilled, so there's nothing meaningfully different to
/// skip in this click-through).
class T4CoachingScreen extends StatefulWidget {
  const T4CoachingScreen({super.key, required this.session, required this.onNext});

  final TrainerOnboardingSession session;
  final VoidCallback onNext;

  @override
  State<T4CoachingScreen> createState() => _T4CoachingScreenState();
}

class _T4CoachingScreenState extends State<T4CoachingScreen> {
  late String _years = widget.session.yearsExperience;
  late final Set<String> _specialities = Set.of(widget.session.specialities);
  late CoachingMode? _mode = widget.session.mode;

  void _submit() {
    final s = widget.session;
    s.yearsExperience = _years;
    s.specialities = _specialities;
    s.mode = _mode;
    widget.onNext();
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
                    Text('2 OF 3', style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1)),
                    const Spacer(),
                    GestureDetector(
                      onTap: _submit,
                      child: Text(
                        'Skip for now',
                        style: AppText.body(13, weight: FontWeight.w600, color: AppColors.textFaint),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const ProgressDots(count: 3, activeCount: 2, onColor: AppColors.yellow),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your coaching', style: AppText.headline(28, height: 1.1)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('YEARS OF EXPERIENCE', style: AppText.eyebrow()),
                  ),
                  OptionChipRow<String>(
                    options: kYearsOptions,
                    labelOf: (y) => y,
                    isSelected: (y) => y == _years,
                    onTap: (y) => setState(() => _years = y),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('CERTIFICATIONS', style: AppText.eyebrow()),
                  ),
                  ...widget.session.certifications.map(
                    (c) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(AppRadii.cardSm),
                        boxShadow: AppShadows.field,
                      ),
                      child: Text(c, style: AppText.body(14, weight: FontWeight.w500)),
                    ),
                  ),
                  Material(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppRadii.pill),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                          boxShadow: AppShadows.field,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon.strokePath(
                              AppIconPaths.plus(),
                              color: AppColors.ink,
                              size: 13,
                              strokeWidth: 2.4,
                            ),
                            const SizedBox(width: 7),
                            Text('Add another', style: AppText.body(12, weight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('SPECIALITIES', style: AppText.eyebrow()),
                  ),
                  OptionChipRow<String>(
                    options: kSpecialityOptions,
                    labelOf: (s) => s,
                    isSelected: (s) => _specialities.contains(s),
                    onTap: (s) => setState(() {
                      if (!_specialities.add(s)) _specialities.remove(s);
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('COACHING MODE', style: AppText.eyebrow()),
                  ),
                  OptionChipRow<CoachingMode>(
                    options: kCoachingModeOptions,
                    labelOf: (m) => m.label,
                    isSelected: (m) => m == _mode,
                    onTap: (m) => setState(() => _mode = m),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: PrimaryCtaButton(label: 'Next → Your handle', onTap: _submit),
          ),
        ],
      ),
    );
  }
}
