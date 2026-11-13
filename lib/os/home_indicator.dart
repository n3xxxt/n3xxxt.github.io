import 'package:flutter/material.dart';

/// Полоска home indicator.
class HomeIndicatorBar extends StatelessWidget {
  const HomeIndicatorBar({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: const SizedBox(width: 134, height: 5),
    );
  }
}
