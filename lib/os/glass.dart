import 'package:flutter/material.dart';

/// Полупрозрачная карточка поверх обоев.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.radius,
    required this.child,
    required this.color,
    this.border,
    this.padding = EdgeInsets.zero,
  });

  final double radius;
  final EdgeInsets padding;
  final Color color;
  final BorderSide? border;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border == null ? null : Border.fromBorderSide(border!),
      ),
      child: child,
    );
  }
}
