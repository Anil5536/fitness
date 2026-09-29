import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/typography.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/back_circle_button.dart';
import '../../widgets/code_input_row.dart';
import '../../widgets/primary_cta_button.dart';
import '../../widgets/role_chip.dart';

/// Shared by C3 (client) and T2 (trainer). The static design shows a
/// "default" code row and a separate "error state" row side by side as
/// two example snapshots of the same widget — here they collapse into
/// one interactive [CodeInputRow] that switches state live.
///
/// [showResendButton] is a real structural difference (T2 has a
/// "Resend code" button; C3 doesn't), not styling.
class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({
    super.key,
    required this.role,
    required this.phoneDisplay,
    required this.expectedCode,
    required this.onSuccess,
    this.showResendButton = false,
  });

  final AppRole role;
  final String phoneDisplay;
  final String expectedCode;
  final VoidCallback onSuccess;
  final bool showResendButton;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  bool _error = false;
  int _secondsLeft = 24;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft == 0) {
        t.cancel();
        return;
      }
      setState(() => _secondsLeft--);
    });
  }

  void _restartCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = 24);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mm = (_secondsLeft ~/ 60).toString();
    final ss = (_secondsLeft % 60).toString().padLeft(2, '0');

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
                  Text('Enter the code we sent', style: AppText.headline(28, height: 1.1)),
                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: AppText.mono(12, weight: FontWeight.w500, color: AppColors.textMuted),
                      children: [
                        TextSpan(text: 'TO +91 ${widget.phoneDisplay} · '),
                        TextSpan(
                          text: 'CHANGE',
                          style: const TextStyle(color: AppColors.errorText, fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()..onTap = () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  CodeInputRow(
                    expectedCode: widget.expectedCode,
                    onSuccess: widget.onSuccess,
                    onError: () => setState(() => _error = true),
                  ),
                  const SizedBox(height: 16),
                  if (_error) ...[
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
                  ] else
                    Text(
                      'RESEND IN $mm:$ss',
                      style: AppText.mono(12, weight: FontWeight.w500, color: AppColors.textFaint),
                    ),
                  if (widget.showResendButton) ...[
                    const SizedBox(height: 18),
                    SecondaryPillButton(
                      label: 'Resend code',
                      onTap: _secondsLeft == 0 ? _restartCountdown : null,
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
