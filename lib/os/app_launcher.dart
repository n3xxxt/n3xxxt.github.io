import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app/ios.dart';
import 'app_icon.dart';
import 'phone_app.dart';

/// Окно приложения, раскрывающееся из иконки на весь экран.
class AppWindow extends StatelessWidget {
  const AppWindow({
    super.key,
    required this.app,
    required this.from,
    required this.radius,
    required this.displayRadius,
    required this.progress,
    required this.drag,
    required this.screen,
    required this.insets,
  });

  final PhoneApp app;
  final Rect from;
  final double radius;
  final double displayRadius;
  final Animation<double> progress;
  final Animation<double> drag;
  final Size screen;
  final EdgeInsets insets;

  @override
  Widget build(BuildContext context) {
    final bg = context.ios.systemGroupedBackground;
    final mq = MediaQuery.of(context);
    final content = MediaQuery(
      data: mq.copyWith(padding: insets, viewPadding: insets),
      child: RepaintBoundary(
        child: Material(
          color: bg,
          child: SizedBox.fromSize(
            size: screen,
            child: Builder(builder: app.builder!),
          ),
        ),
      ),
    );
    return AnimatedBuilder(
      animation: Listenable.merge([progress, drag]),
      child: content,
      builder: (context, child) {
        final c = progress.value.clamp(0.0, 1.0);
        final d = math.max(0.0, drag.value);
        final t = (d / (screen.height * 0.6)).clamp(0.0, 1.0);
        final s = 1 - 0.5 * t;
        final target = Rect.fromCenter(
          center: Offset(screen.width / 2, screen.height / 2 - 0.25 * d),
          width: screen.width * s,
          height: screen.height * s,
        );
        final rect = Rect.lerp(from, target, c)!;
        final fullRadius = displayRadius + (36 - displayRadius) * t;
        final r = radius + (fullRadius - radius) * c;
        final glyphOpacity = (1 - c / 0.12).clamp(0.0, 1.0);
        final scale = rect.width / screen.width;
        final glyphSize = math.min(from.width, from.height);
        return Positioned.fromRect(
          rect: rect,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                OverflowBox(
                  minWidth: screen.width,
                  maxWidth: screen.width,
                  minHeight: screen.height,
                  maxHeight: screen.height,
                  child: Transform.scale(scale: scale, child: child),
                ),
                if (glyphOpacity > 0)
                  Center(
                    child: Opacity(
                      opacity: glyphOpacity,
                      child: AppGlyph(app: app, size: glyphSize),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
