import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/icons/app_icon.dart';
import '../core/icons/icon_paths.dart';

/// The "routinely" logo glyph — two overlapping filled arches.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key, this.size = 26, this.color = AppColors.ink});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppIcon(
      size: size,
      viewBox: const Size(64, 64),
      layers: [
        IconLayer.fill(AppIconPaths.logoArchTop(), color: color),
        IconLayer.fill(AppIconPaths.logoArchBottom(), color: color),
      ],
    );
  }
}
