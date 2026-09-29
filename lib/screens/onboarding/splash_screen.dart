import 'dart:math' as math;
import 'package:flutter/material.dart';

const _bg = Color(0xFFEAE5DD);
const _ink = Color(0xFF1B1B22);

const _totalMs = 3400.0;

/// Animated splash:
/// 1. the two logo halves fly in from opposite corners and lock together
///    (top half 10 to the left, bottom half 10 to the right),
/// 2. the gap "blinks" once,
/// 3. the app name rises in letter by letter under the logo.
///
/// Usage: SplashScreen(onFinished: () => Navigator.pushReplacement(...))
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.appName = 'Routinely', this.onFinished});
  final String appName;
  final VoidCallback? onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3400),
  );

  @override
  void initState() {
    super.initState();
    _c.forward().whenComplete(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) widget.onFinished?.call();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.of(context).disableAnimations;
    final logoSize = MediaQuery.of(context).size.width * 0.34;
    return Scaffold(
      backgroundColor: _bg,
      body: Center(
        child: AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            final ms = reduce ? _totalMs : _c.value * _totalMs;
            return Stack(
              alignment: Alignment.center,
              children: [
                // Logo stays exactly centered (matches the native splash)
                SizedBox(
                  width: logoSize,
                  height: logoSize,
                  child: CustomPaint(painter: _LogoPainter(ms, settled: reduce)),
                ),
                // Wordmark sits below the logo
                Transform.translate(
                  offset: Offset(0, logoSize / 2 + 44),
                  child: _Wordmark(text: widget.appName, ms: ms),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Progress (0..1) of a segment that starts at [start] ms and lasts [dur] ms.
double _seg(double ms, double start, double dur,
    [Curve curve = Curves.easeOutCubic]) {
  return curve.transform(((ms - start) / dur).clamp(0.0, 1.0));
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.text, required this.ms});
  final String text;
  final double ms;

  @override
  Widget build(BuildContext context) {
    const startAt = 2000.0; // after the logo has locked and blinked
    const stagger = 55.0; // delay between letters
    const letterDur = 520.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < text.length; i++)
          Builder(builder: (_) {
            final e = _seg(ms, startAt + i * stagger, letterDur);
            return Opacity(
              opacity: e,
              child: Transform.translate(
                offset: Offset(0, (1 - e) * 16),
                child: Text(
                  text[i],
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8,
                    height: 1.1,
                  ),
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  _LogoPainter(this.ms, {this.settled = false});
  final double ms; // 0.._totalMs
  final bool settled;

  // Logo geometry on a 100x100 canvas
  static const _r = 46.0;
  static const _xl = 4.17, _xr = 95.83;

  // Resting horizontal offset of the halves (logo units, 100 = full logo width).
  // Top half sits 10 to the LEFT, bottom half 10 to the RIGHT.
  // Change the sign of the two values to swap directions.
  static const _shift = 10.0;

  Path get _top => Path()
    ..moveTo(_xl, 46)
    ..arcToPoint(const Offset(_xr, 46),
        radius: const Radius.circular(_r), clockwise: true)
    ..close();

  Path get _bottom => Path()
    ..moveTo(_xl, 54)
    ..arcToPoint(const Offset(_xr, 54),
        radius: const Radius.circular(_r), clockwise: false)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 100, size.height / 100);

    // Phase 1 (0 → 1600ms): fly in + rotate, eased
    final p = _seg(ms, 0, 1600, Curves.easeInOutCubic);
    final opacity = _seg(ms, 0, 900, Curves.linear);
    // Phase 2 (1600 → 2150ms): gap opens and closes once
    final t = ((ms - 1600) / 550).clamp(0.0, 1.0);
    final blink = settled ? 0.0 : 7 * math.sin(math.pi * t);

    final paint = Paint()
      ..color = _ink.withAlpha((opacity * 255).round())
      ..isAntiAlias = true;

    _draw(canvas, _top, paint, const Offset(-90, -60), -math.pi, p, -blink,
        -_shift);
    _draw(canvas, _bottom, paint, const Offset(90, 60), math.pi, p, blink,
        _shift);
  }

  void _draw(Canvas canvas, Path path, Paint paint, Offset from, double angle,
      double p, double dy, double restDx) {
    final k = 1 - p;
    canvas.save();
    canvas.translate(from.dx * k + restDx, from.dy * k + dy);
    canvas.translate(50, 50);
    canvas.rotate(angle * k);
    canvas.translate(-50, -50);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(_LogoPainter old) => old.ms != ms;
}