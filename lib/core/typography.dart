import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Text style builders. CSS `letter-spacing` in the source design is in
/// `em`, but Flutter's [TextStyle.letterSpacing] is in logical pixels —
/// every builder here takes the *em* value straight from the design and
/// converts it (`em * fontSize`) so call sites can copy design values
/// directly instead of eyeballing px.
abstract final class AppText {
  /// Bricolage Grotesque headlines. Design uses -0.03em tracking almost
  /// everywhere; overridable for the rare exception.
  static TextStyle headline(
    double size, {
    Color color = AppColors.ink,
    FontWeight weight = FontWeight.w700,
    double? height,
    double letterSpacingEm = -0.03,
  }) {
    return GoogleFonts.bricolageGrotesque(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: size * letterSpacingEm,
    );
  }

  /// Instrument Sans body/UI text.
  static TextStyle body(
    double size, {
    Color color = AppColors.ink,
    FontWeight weight = FontWeight.w400,
    double? height,
    double letterSpacingEm = 0,
  }) {
    return GoogleFonts.instrumentSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacingEm == 0 ? null : size * letterSpacingEm,
    );
  }

  /// Spline Sans Mono — used for OTP digits, codes, and numeric values.
  static TextStyle mono(
    double size, {
    Color color = AppColors.ink,
    FontWeight weight = FontWeight.w600,
    double? height,
    double letterSpacingEm = 0,
  }) {
    return GoogleFonts.splineSansMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacingEm == 0 ? null : size * letterSpacingEm,
    );
  }

  /// Small uppercase Spline Sans Mono eyebrow/section labels
  /// (e.g. "PHONE NUMBER", "1 OF 3"). Design default is 9px / .12em.
  static TextStyle eyebrow({
    double size = 9,
    Color color = AppColors.textFaint,
    FontWeight weight = FontWeight.w500,
    double letterSpacingEm = 0.12,
  }) {
    return mono(
      size,
      color: color,
      weight: weight,
      letterSpacingEm: letterSpacingEm,
    );
  }
}
