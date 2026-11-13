import 'package:flutter/material.dart';

import 'clock.dart';

/// Нарисованный статус-бар: время, сеть, Wi-Fi, батарея.
class OsStatusBar extends StatelessWidget {
  const OsStatusBar({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      height: 1,
      color: color,
    );
    return SizedBox(
      height: 36,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Row(
          children: [
            Clock(
              builder: (context, now) {
                final h = now.hour.toString().padLeft(2, '0');
                final m = now.minute.toString().padLeft(2, '0');
                return Text('$h:$m', style: style);
              },
            ),
            const Spacer(),
            _Glyph(const Size(18, 12), _SignalPainter(color)),
            const SizedBox(width: 6),
            _Glyph(const Size(17, 12), _WifiPainter(color)),
            const SizedBox(width: 6),
            _Glyph(const Size(27, 13), _BatteryPainter(color)),
          ],
        ),
      ),
    );
  }
}

class _Glyph extends StatelessWidget {
  const _Glyph(this.size, this.painter);

  final Size size;
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: size, painter: painter);
}

class _SignalPainter extends CustomPainter {
  const _SignalPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var i = 0; i < 4; i++) {
      final h = 4 + i * 2.67;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(i * 5.0, size.height - h, 3, h),
          const Radius.circular(1),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SignalPainter old) => old.color != color;
}

class _WifiPainter extends CustomPainter {
  const _WifiPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (final r in const [5.0, 9.0, 13.0]) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        -3.1416 * 0.75,
        3.1416 / 2,
        false,
        stroke,
      );
    }
    canvas.drawCircle(center.translate(0, -1), 1.6, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_WifiPainter old) => old.color != color;
}

class _BatteryPainter extends CustomPainter {
  const _BatteryPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final body = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.5, 0.5, 23, size.height - 1),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      body,
      Paint()
        ..color = color.withValues(alpha: 0.45)
        ..style = PaintingStyle.stroke,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(2.5, 2.5, 19, size.height - 5),
        const Radius.circular(2),
      ),
      Paint()..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(24.8, size.height / 2 - 2, 1.8, 4),
        const Radius.circular(1),
      ),
      Paint()..color = color.withValues(alpha: 0.5),
    );
  }

  @override
  bool shouldRepaint(_BatteryPainter old) => old.color != color;
}
