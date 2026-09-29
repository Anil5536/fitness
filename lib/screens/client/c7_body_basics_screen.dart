import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/radii.dart';
import '../../core/shadows.dart';
import '../../core/typography.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../state/client_onboarding_session.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/labeled_field_card.dart';
import '../../widgets/option_chip_row.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/progress_dots.dart';
import '../../widgets/role_chip.dart';

/// C7 — prefilled per the plan (its own styling uses the same bold
/// `val`-style convention as the other explicitly-prefilled screens),
/// except `injuries`, which the design renders with genuine hint-text
/// styling and so starts empty.
class C7BodyBasicsScreen extends StatefulWidget {
  const C7BodyBasicsScreen({super.key, required this.session, required this.onFinish});

  final ClientOnboardingSession session;
  final VoidCallback onFinish;

  @override
  State<C7BodyBasicsScreen> createState() => _C7BodyBasicsScreenState();
}

class _C7BodyBasicsScreenState extends State<C7BodyBasicsScreen> {
  late final _height = TextEditingController(text: '${BodyBasicsDefaults.heightCm}');
  late final _weight = TextEditingController(text: '${BodyBasicsDefaults.weightKg}');
  late final _target = TextEditingController(text: '${BodyBasicsDefaults.targetWeightKg}');
  final _injuries = TextEditingController();
  Diet _diet = BodyBasicsDefaults.diet;

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    _target.dispose();
    _injuries.dispose();
    super.dispose();
  }

  void _submit() {
    final s = widget.session;
    s.heightCm = double.tryParse(_height.text);
    s.weightKg = double.tryParse(_weight.text);
    s.targetWeightKg = double.tryParse(_target.text);
    s.diet = _diet;
    s.injuries = _injuries.text;
    widget.onFinish();
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
                    const RoleChip(role: AppRole.client),
                    const SizedBox(width: 10),
                    Text('2 OF 2', style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1)),
                  ],
                ),
                const SizedBox(height: 14),
                const ProgressDots(count: 2, activeCount: 2, onColor: AppColors.greenBright),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your body basics', style: AppText.headline(28, height: 1.1)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledFieldCard(
                          label: 'HEIGHT',
                          controller: _height,
                          mono: true,
                          suffix: 'cm',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: LabeledFieldCard(
                          label: 'WEIGHT NOW',
                          controller: _weight,
                          mono: true,
                          suffix: 'kg',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  LabeledFieldCard(
                    label: 'TARGET WEIGHT · OPTIONAL',
                    controller: _target,
                    mono: true,
                    suffix: 'kg',
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('HOW DO YOU EAT?', style: AppText.eyebrow()),
                  ),
                  DietSegmentedControl(
                    selected: _diet,
                    onChanged: (d) => setState(() => _diet = d),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('ANY INJURIES OR CONDITIONS?', style: AppText.eyebrow()),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppRadii.cardSm),
                      boxShadow: AppShadows.field,
                    ),
                    child: TextField(
                      controller: _injuries,
                      style: AppText.body(14, height: 1.5, color: AppColors.ink),
                      decoration: InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: 'e.g. knee pain, PCOS, none',
                        hintStyle: AppText.body(14, height: 1.5, color: AppColors.textPlaceholder),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.ink, shape: BoxShape.circle),
                        child: Text(
                          kAarav.initials,
                          style: AppText.headline(8, color: AppColors.yellow),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          'Aarav can see this — it helps him plan for you.',
                          style: AppText.body(12, height: 1.5, color: AppColors.textMuted),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: PrimaryCtaButton(label: 'Finish', onTap: _submit),
          ),
        ],
      ),
    );
  }
}
