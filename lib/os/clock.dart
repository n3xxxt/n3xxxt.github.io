import 'dart:async';

import 'package:flutter/widgets.dart';

/// Перестраивает потомка в начале каждой минуты.
class Clock extends StatefulWidget {
  const Clock({super.key, required this.builder});

  final Widget Function(BuildContext context, DateTime now) builder;

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  void _schedule() {
    final n = DateTime.now();
    final next = DateTime(n.year, n.month, n.day, n.hour, n.minute + 1);
    _timer = Timer(next.difference(n), () {
      if (!mounted) return;
      setState(() => _now = DateTime.now());
      _schedule();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _now);
}
