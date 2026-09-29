import 'package:flutter/material.dart';

import '../../core/colors.dart';
import '../../core/icons/app_icon.dart';
import '../../core/icons/icon_paths.dart';
import '../../core/radii.dart';
import '../../core/typography.dart';
import '../../data/models.dart';
import '../../widgets/app_shell.dart';
import '../../widgets/primary_cta_button.dart';

/// C5 — reused by both arrival paths that resolve to a single trainer:
/// the default-phone OTP path (which already knows the client's name
/// from the trainer's prefill, so [clientInitials] is shown) and the
/// C4 trainer-code path (no prior record, so a generic avatar shows).
class C5ConnectedScreen extends StatelessWidget {
  const C5ConnectedScreen({
    super.key,
    required this.trainer,
    required this.onContinue,
    this.clientInitials,
  });

  final TrainerMock trainer;
  final String? clientInitials;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      child: Stack(
        children: [
          Positioned(
            left: -60,
            top: 280,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x4D2F6E43), Color(0x002F6E43)],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(9, 7, 12, 7),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppIcon.strokePath(
                              AppIconPaths.check(),
                              color: AppColors.white,
                              size: 13,
                              strokeWidth: 3,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              "YOU'RE CONNECTED WITH ${trainer.name.split(' ').first.toUpperCase()}",
                              style: AppText.mono(10, weight: FontWeight.w600, color: AppColors.white, letterSpacingEm: 0.08),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          _avatar(clientInitials, AppColors.tan, AppColors.ink),
                          SizedBox(
                            width: 60,
                            height: 12,
                            child: CustomPaint(painter: _DashPainter()),
                          ),
                          _avatar(trainer.initials, AppColors.ink, AppColors.yellow),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Text('${trainer.name.split(' ').first} is now your coach', style: AppText.headline(30, height: 1.08)),
                      const SizedBox(height: 8),
                      Text(
                        'MATCHED FROM YOUR NUMBER',
                        style: AppText.eyebrow(size: 10, letterSpacingEm: 0.1),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Your plan will appear as soon as ${trainer.name.split(' ').first} assigns it.',
                        style: AppText.body(14, height: 1.6, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 34),
                child: PrimaryCtaButton(label: 'Set up your profile', onTap: onContinue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar(String? initials, Color bg, Color fg) {
    return Container(
      width: 74,
      height: 74,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: initials == null
          ? AppIcon.strokePath(AppIconPaths.tabProfile(), color: fg, size: 28, strokeWidth: 1.8)
          : Text(initials, style: AppText.headline(23, color: fg)),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.green
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    const dashWidth = 1.0;
    const gapWidth = 9.0;
    var x = 0.0;
    final y = size.height / 2;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
      x += dashWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
