import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/typography.dart';
import '../../data/models.dart';
import '../../state/client_onboarding_session.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/labeled_field_card.dart';
import '../../widgets/option_chip_row.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/progress_dots.dart';
import '../../widgets/role_chip.dart';

/// Covers both C6 (empty) and C6b (prefilled) as one screen — the only
/// difference is whether [session.entryPath] carried prefill data
/// forward, which flips every field between placeholder/`ph` styling
/// and bold/`val` + "FROM AARAV"-chip styling.
class C6ProfileScreen extends StatefulWidget {
  const C6ProfileScreen({
    super.key,
    required this.session,
    required this.prefill,
    required this.onNext,
  });

  final ClientOnboardingSession session;
  final ClientPrefillData? prefill;
  final VoidCallback onNext;

  @override
  State<C6ProfileScreen> createState() => _C6ProfileScreenState();
}

class _C6ProfileScreenState extends State<C6ProfileScreen> {
  late final _first = TextEditingController(text: widget.prefill?.firstName ?? '');
  late final _last = TextEditingController(text: widget.prefill?.lastName ?? '');
  late final _city = TextEditingController(text: widget.prefill?.city ?? '');
  late final _dob = TextEditingController(
    text: widget.prefill == null ? '' : _formatDob(widget.prefill!.dob),
  );
  Gender? _gender;

  static String _formatDob(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} / ${d.month.toString().padLeft(2, '0')} / ${d.year}';

  @override
  void initState() {
    super.initState();
    // Sneha's invite already records her as female; a code-entry client
    // (no prefill) has no gender on file yet.
    _gender = widget.prefill != null ? Gender.female : null;
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _city.dispose();
    _dob.dispose();
    super.dispose();
  }

  void _submit() {
    final s = widget.session;
    s.firstName = _first.text;
    s.lastName = _last.text;
    s.city = _city.text;
    s.gender = _gender;
    s.dob = widget.prefill?.dob;
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    final isPrefilled = widget.prefill != null;
    const badge = 'FROM AARAV';

    return AppShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, kScreenTopPad, 22, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    RoleChip(role: AppRole.client),
                    SizedBox(width: 10),
                    _StepLabel(),
                  ],
                ),
                const SizedBox(height: 14),
                const ProgressDots(count: 2, activeCount: 1, onColor: AppColors.greenBright),
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
                  if (isPrefilled) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Aarav already filled some of this from your form — just check it.',
                      style: AppText.body(13, height: 1.55, color: AppColors.textMuted),
                    ),
                  ],
                  SizedBox(height: isPrefilled ? 18 : 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(color: AppColors.tan, shape: BoxShape.circle),
                        child: isPrefilled
                            ? Text(
                                '${widget.prefill!.firstName[0]}${widget.prefill!.lastName[0]}',
                                style: AppText.headline(22),
                              )
                            : AppIcon.strokePath(
                                AppIconPaths.tabProfile(),
                                color: AppColors.ink,
                                size: 28,
                                strokeWidth: 1.8,
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
                        child: LabeledFieldCard(
                          label: 'FIRST NAME',
                          controller: _first,
                          hint: 'Your name',
                          prefilledBadge: isPrefilled ? badge : null,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: LabeledFieldCard(
                          label: 'LAST NAME',
                          controller: _last,
                          hint: 'Surname',
                          prefilledBadge: isPrefilled ? badge : null,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 18, 4, 9),
                    child: Text('GENDER · OPTIONAL', style: AppText.eyebrow()),
                  ),
                  OptionChipRow<Gender>(
                    options: kGenderOptionsList,
                    labelOf: (g) => g.label,
                    isSelected: (g) => g == _gender,
                    onTap: (g) => setState(() => _gender = g),
                  ),
                  const SizedBox(height: 14),
                  if (isPrefilled)
                    LabeledFieldCard(
                      label: 'DATE OF BIRTH',
                      controller: _dob,
                      mono: true,
                      readOnly: true,
                    )
                  else
                    LabeledFieldCard(
                      label: 'DATE OF BIRTH',
                      controller: _dob,
                      mono: true,
                      hint: 'DD / MM / YYYY',
                    ),
                  const SizedBox(height: 9),
                  LabeledFieldCard(
                    label: 'CITY',
                    controller: _city,
                    hint: 'Where do you live?',
                    prefilledBadge: isPrefilled ? badge : null,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 10, 22, 32),
            child: PrimaryCtaButton(label: 'Next → Body basics', onTap: _submit),
          ),
        ],
      ),
    );
  }
}

class _StepLabel extends StatelessWidget {
  const _StepLabel();

  @override
  Widget build(BuildContext context) {
    return Text('1 OF 2', style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1));
  }
}

const kGenderOptionsList = Gender.values;
