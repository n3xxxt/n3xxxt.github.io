import 'package:flutter/material.dart';

import '../app/theme.dart';

/// Обои телефона: градиент с акцентным свечением и кольцами-мишенью.
class Wallpaper extends StatelessWidget {
  const Wallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(
        painter: _WallpaperPainter(
          dark: Theme.of(context).brightness == Brightness.dark,
          accent: context.tokens.accent,
        ),
      ),
    );
  }
}

class _WallpaperPainter extends CustomPainter {
  const _WallpaperPainter({required this.dark, required this.accent});

  final bool dark;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.clipRect(rect);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: dark
              ? const [Color(0xFF242225), Color(0xFF151416), Color(0xFF0C0B0C)]
              : const [Color(0xFFF6C3A0), Color(0xFFEFA176), Color(0xFFE2804F)],
        ).createShader(rect),
    );
    _glow(
      canvas,
      Offset(size.width * 0.5, size.height),
      size.height * 0.7,
      dark ? 0.38 : 0.30,
    );
    _glow(
      canvas,
      Offset(size.width * 0.1, size.height * 0.05),
      size.height * 0.4,
      dark ? 0.10 : 0.14,
    );
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = (dark ? Colors.white : accent).withValues(alpha: 0.06);
    final center = Offset(size.width * 0.5, size.height * 0.86);
    for (var i = 1; i <= 6; i++) {
      canvas.drawCircle(center, size.width * 0.18 * i, ring);
    }
  }

  void _glow(Canvas canvas, Offset center, double radius, double alpha) {
    final area = Rect.fromCircle(center: center, radius: radius);
    canvas.drawRect(
      area,
      Paint()
        ..shader = RadialGradient(
          colors: [
            accent.withValues(alpha: alpha),
            accent.withValues(alpha: 0),
          ],
        ).createShader(area),
    );
  }

  @override
  bool shouldRepaint(_WallpaperPainter old) =>
      old.dark != dark || old.accent != accent;
}
