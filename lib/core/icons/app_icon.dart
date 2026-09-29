import 'package:flutter/material.dart';

/// One paintable layer of an [AppIcon] — either a stroked or filled path,
/// in the icon's original viewBox coordinate space.
class IconLayer {
  const IconLayer.stroke(
    this.path, {
    required this.color,
    this.strokeWidth = 2,
    this.cap = StrokeCap.round,
    this.join = StrokeJoin.round,
  }) : style = PaintingStyle.stroke;

  const IconLayer.fill(this.path, {required this.color})
    : style = PaintingStyle.fill,
      strokeWidth = 0,
      cap = StrokeCap.butt,
      join = StrokeJoin.miter;

  final Path path;
  final Color color;
  final PaintingStyle style;
  final double strokeWidth;
  final StrokeCap cap;
  final StrokeJoin join;
}

/// Renders one or more [IconLayer]s scaled from their source viewBox
/// into a widget of [size] x [size] logical pixels.
class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.layers,
    required this.size,
    this.viewBox = const Size(24, 24),
  });

  /// Single-color stroked icon shorthand.
  AppIcon.strokePath(
    Path path, {
    super.key,
    required Color color,
    required this.size,
    double strokeWidth = 2,
    this.viewBox = const Size(24, 24),
  }) : layers = [IconLayer.stroke(path, color: color, strokeWidth: strokeWidth)];

  final List<IconLayer> layers;
  final double size;
  final Size viewBox;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _IconPainter(layers, viewBox)),
    );
  }
}

/// Three filled dots ("more" tab icon) — the source SVG expresses these
/// as zero-length `h.01` strokes with a round cap, which Flutter can't
/// reproduce with a `Path`; three small filled circles render identically.
class AppIconDots extends StatelessWidget {
  const AppIconDots({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    const r = 1.0; // dot radius in the 24x24 viewBox, matching the ~1.9 stroke width of sibling icons
    final path = Path()
      ..addOval(Rect.fromCircle(center: const Offset(5.5, 12), radius: r))
      ..addOval(Rect.fromCircle(center: const Offset(12, 12), radius: r))
      ..addOval(Rect.fromCircle(center: const Offset(18.5, 12), radius: r));
    return AppIcon(
      layers: [IconLayer.fill(path, color: color)],
      size: size,
    );
  }
}

class _IconPainter extends CustomPainter {
  _IconPainter(this.layers, this.viewBox);

  final List<IconLayer> layers;
  final Size viewBox;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / viewBox.width, size.height / viewBox.height);
    for (final layer in layers) {
      final paint = Paint()
        ..color = layer.color
        ..style = layer.style
        ..strokeWidth = layer.strokeWidth
        ..strokeCap = layer.cap
        ..strokeJoin = layer.join
        ..isAntiAlias = true;
      canvas.drawPath(layer.path, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _IconPainter oldDelegate) =>
      oldDelegate.layers != layers || oldDelegate.viewBox != viewBox;
}
