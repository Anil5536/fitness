import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/typography.dart';
import '../../data/models.dart';
import '../../state/trainer_onboarding_session.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/labeled_field_card.dart';
import '../../widgets/option_chip_row.dart';
import '../../widgets/primary_cta_button.dart' show PrimaryCtaButton, SecondaryPillButton;
import '../../widgets/progress_dots.dart';
import '../../widgets/role_chip.dart';

/// T3 — prefilled with Aarav's example values exactly as the design
/// shows them (bold/`val` styling there, not placeholder styling).
class T3ProfileScreen extends StatefulWidget {
  const T3ProfileScreen({super.key, required this.session, required this.onNext});

  final TrainerOnboardingSession session;
  final VoidCallback onNext;

  @override
  State<T3ProfileScreen> createState() => _T3ProfileScreenState();
}

class _T3ProfileScreenState extends State<T3ProfileScreen> {
  late final _first = TextEditingController(text: widget.session.firstName);
  late final _last = TextEditingController(text: widget.session.lastName);
  late final _city = TextEditingController(text: widget.session.city);
  late Gender? _gender = widget.session.gender;

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _city.dispose();
    super.dispose();
  }

  void _submit() {
    final s = widget.session;
    s.firstName = _first.text;
    s.lastName = _last.text;
    s.city = _city.text;
    s.gender = _gender;
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
                    Text('1 OF 3', style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1)),
                  ],
                ),
                const SizedBox(height: 14),
                const ProgressDots(count: 3, activeCount: 1, onColor: AppColors.yellow),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About you', style: AppText.headline(28, height: 1.1)),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.tan, shape: BoxShape.circle),
                        child: Text(
                          _first.text.isNotEmpty && _last.text.isNotEmpty
                              ? '${_first.text[0]}${_last.text[0]}'
                              : '',
                          style: AppText.headline(22),
                        ),
                      ),
                      const SizedBox(width: 14),
                      SecondaryPillButton(label: 'Add photo', onTap: () {}),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: LabeledFieldCard(label: 'FIRST NAME', controller: _first),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: LabeledFieldCard(label: 'LAST NAME', controller: _last),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('GENDER · OPTIONAL', style: AppText.eyebrow()),
                  ),
                  OptionChipRow<Gender>(
                    options: Gender.values,
                    labelOf: (g) => g.label,
                    isSelected: (g) => g == _gender,
                    onTap: (g) => setState(() => _gender = g),
                  ),
                  const SizedBox(height: 14),
                  LabeledFieldCard(label: 'CITY', controller: _city),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: PrimaryCtaButton(label: 'Next → Your coaching', onTap: _submit),
          ),
        ],
      ),
    );
  }
}
