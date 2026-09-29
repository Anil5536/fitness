import 'package:flutter/material.dart';

/// Hand-ported `Path` data for every icon used in the design, copied
/// from the source SVG `d` attributes (viewBox 0 0 24 24 unless noted).
/// Kept as a fixed, closed set for this app's small onboarding icon
/// vocabulary — see the plan for why this is hand-ported instead of
/// pulled in via `flutter_svg`.
abstract final class AppIconPaths {
  static Path backChevron() => Path()
    ..moveTo(14.5, 5)
    ..lineTo(8, 12)
    ..lineTo(14.5, 19);

  static Path check() => Path()
    ..moveTo(5, 12.5)
    ..lineTo(10, 17.5)
    ..lineTo(19, 7);

  static Path plus() => Path()
    ..moveTo(12, 5)
    ..lineTo(12, 19)
    ..moveTo(5, 12)
    ..lineTo(19, 12);

  /// "routinely" logo mark, viewBox 0 0 64 64 — two overlapping arches.
  static Path logoArchTop() => Path()
    ..moveTo(5, 29.5)
    ..arcToPoint(
      const Offset(51, 29.5),
      radius: const Radius.circular(23),
      clockwise: true,
    )
    ..close();

  static Path logoArchBottom() => Path()
    ..moveTo(13, 34.5)
    ..arcToPoint(
      const Offset(59, 34.5),
      radius: const Radius.circular(23),
      clockwise: false,
    )
    ..close();

  static Path googleBlue() => Path()
    ..moveTo(23, 12.3)
    ..cubicTo(23, 11.5, 22.9, 10.7, 22.8, 10.0)
    ..lineTo(12, 10.0)
    ..lineTo(12, 14.4)
    ..lineTo(18.2, 14.4)
    ..arcToPoint(
      const Offset(15.9, 17.9),
      radius: const Radius.circular(5.3),
      clockwise: true,
    )
    ..lineTo(15.9, 20.8)
    ..lineTo(19.6, 20.8)
    ..cubicTo(21.8, 18.8, 23.0, 15.8, 23.0, 12.3)
    ..close();

  static Path googleGreen() => Path()
    ..moveTo(12, 23.5)
    ..cubicTo(15.1, 23.5, 17.7, 22.5, 19.6, 20.7)
    ..lineTo(15.9, 17.8)
    ..cubicTo(14.9, 18.5, 13.6, 18.9, 12.0, 18.9)
    ..cubicTo(9.0, 18.9, 6.5, 16.9, 5.6, 14.2)
    ..lineTo(1.8, 14.2)
    ..lineTo(1.8, 17.2)
    ..arcToPoint(
      const Offset(12, 23.5),
      radius: const Radius.circular(11.5),
      clockwise: false,
    )
    ..close();

  static Path googleYellow() => Path()
    ..moveTo(5.6, 14.2)
    ..arcToPoint(
      const Offset(5.6, 9.8),
      radius: const Radius.circular(6.9),
      clockwise: true,
    )
    ..lineTo(5.6, 6.8)
    ..lineTo(1.8, 6.8)
    ..arcToPoint(
      const Offset(1.8, 17.2),
      radius: const Radius.circular(11.5),
      clockwise: false,
    )
    ..lineTo(5.6, 14.2)
    ..close();

  static Path googleRed() => Path()
    ..moveTo(12, 5.1)
    ..cubicTo(13.7, 5.1, 15.2, 5.7, 16.4, 6.8)
    ..lineTo(19.7, 3.5)
    ..arcToPoint(
      const Offset(1.8, 6.8),
      radius: const Radius.circular(11.5),
      clockwise: false,
    )
    ..lineTo(5.6, 9.8)
    ..cubicTo(6.5, 7.1, 9.0, 5.1, 12.0, 5.1)
    ..close();

  static Path apple() => Path()
    ..moveTo(16.3, 12.7)
    ..cubicTo(16.3, 10.4, 18.2, 9.3, 18.3, 9.2)
    ..cubicTo(17.2, 7.6, 15.5, 7.4, 14.9, 7.4)
    ..cubicTo(13.5, 7.3, 12.1, 8.2, 11.4, 8.2)
    ..cubicTo(10.7, 8.2, 9.6, 7.4, 8.4, 7.4)
    ..cubicTo(6.9, 7.4, 5.4, 8.3, 4.6, 9.7)
    ..cubicTo(3.0, 12.5, 4.2, 16.7, 5.8, 19.0)
    ..cubicTo(6.6, 20.1, 7.5, 21.3, 8.7, 21.3)
    ..cubicTo(9.9, 21.3, 10.3, 20.6, 11.7, 20.6)
    ..cubicTo(13.1, 20.6, 13.5, 21.3, 14.7, 21.3)
    ..cubicTo(15.9, 21.3, 16.7, 20.2, 17.5, 19.1)
    ..cubicTo(18.4, 17.8, 18.8, 16.6, 18.8, 16.5)
    ..cubicTo(18.7, 16.5, 16.3, 15.5, 16.3, 12.7)
    ..close()
    ..moveTo(14.3, 5.6)
    ..cubicTo(14.9, 4.8, 15.4, 3.7, 15.3, 2.6)
    ..cubicTo(14.3, 2.6, 13.1, 3.3, 12.4, 4.1)
    ..cubicTo(11.8, 4.8, 11.3, 5.9, 11.4, 7.0)
    ..cubicTo(12.5, 7.1, 13.6, 6.4, 14.3, 5.6)
    ..close();

  static Path tabHome() => Path()
    ..moveTo(3.2, 10.6)
    ..lineTo(12, 3.4)
    ..lineTo(20.8, 10.6)
    ..lineTo(20.8, 20.6)
    ..lineTo(3.2, 20.6)
    ..close();

  static Path tabLeads() => Path()
    ..moveTo(3.5, 4.5)
    ..lineTo(20.5, 4.5)
    ..lineTo(14, 12.6)
    ..lineTo(14, 19)
    ..lineTo(10, 20.6)
    ..lineTo(10, 12.6)
    ..close();

  static Path tabClients() => Path()
    ..moveTo(9, 4.6)
    ..arcToPoint(
      const Offset(9, 11.0),
      radius: const Radius.circular(3.2),
      largeArc: true,
      clockwise: true,
    )
    ..arcToPoint(
      const Offset(9, 4.6),
      radius: const Radius.circular(3.2),
      clockwise: true,
    )
    ..moveTo(2.6, 19.4)
    ..cubicTo(2.6, 16.1, 5.5, 14.4, 9.0, 14.4)
    ..cubicTo(12.5, 14.4, 15.4, 16.1, 15.4, 19.4)
    ..moveTo(16, 5.2)
    ..arcToPoint(
      const Offset(16, 11.0),
      radius: const Radius.circular(3),
      clockwise: true,
    )
    ..moveTo(17.6, 14.6)
    ..cubicTo(20.0, 15.0, 21.4, 16.5, 21.4, 19.0);

  static Path tabPlans() => Path()
    ..moveTo(9, 3.6)
    ..lineTo(15, 3.6)
    ..lineTo(15, 6.4)
    ..lineTo(9, 6.4)
    ..close()
    ..moveTo(6.2, 6.4)
    ..lineTo(17.8, 6.4)
    ..lineTo(17.8, 20.4)
    ..lineTo(6.2, 20.4)
    ..close()
    ..moveTo(9.2, 11)
    ..lineTo(14.8, 11)
    ..moveTo(9.2, 15)
    ..lineTo(14.8, 15);

  static Path tabToday() => Path()
    ..moveTo(4.2, 6.8)
    ..lineTo(19.8, 6.8)
    ..lineTo(19.8, 20.2)
    ..lineTo(4.2, 20.2)
    ..close()
    ..moveTo(8.4, 3.4)
    ..lineTo(8.4, 7.4)
    ..moveTo(15.6, 3.4)
    ..lineTo(15.6, 7.4)
    ..moveTo(4.2, 11)
    ..lineTo(19.8, 11);

  static Path tabPlan() => Path()
    ..moveTo(4.4, 7)
    ..lineTo(19.6, 7)
    ..moveTo(4.4, 12)
    ..lineTo(19.6, 12)
    ..moveTo(4.4, 17)
    ..lineTo(14.0, 17);

  static Path tabProgress() => Path()
    ..moveTo(4, 19.6)
    ..lineTo(20, 19.6)
    ..moveTo(7.4, 16.4)
    ..lineTo(7.4, 11.2)
    ..moveTo(12, 16.4)
    ..lineTo(12, 7.2)
    ..moveTo(16.6, 16.4)
    ..lineTo(16.6, 11);

  /// Also used standalone as the default profile-photo placeholder icon.
  static Path tabProfile() => Path()
    ..moveTo(12, 4.2)
    ..arcToPoint(
      const Offset(12, 11.4),
      radius: const Radius.circular(3.6),
      largeArc: true,
      clockwise: true,
    )
    ..arcToPoint(
      const Offset(12, 4.2),
      radius: const Radius.circular(3.6),
      clockwise: true,
    )
    ..moveTo(4.4, 20.4)
    ..cubicTo(4.4, 16.7, 7.8, 14.8, 12.0, 14.8)
    ..cubicTo(16.2, 14.8, 19.6, 16.7, 19.6, 20.4);
}
