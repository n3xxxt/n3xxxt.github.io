import 'package:flutter/widgets.dart';

/// Иконка на рабочем столе: внутреннее приложение или внешняя ссылка.
class PhoneApp {
  const PhoneApp({
    required this.id,
    required this.label,
    required this.icon,
    required this.colors,
    this.glyphColor = const Color(0xFFFFFFFF),
    this.builder,
    this.url,
  }) : assert((builder == null) != (url == null));

  final String id;
  final String label;
  final IconData icon;
  final List<Color> colors;
  final Color glyphColor;
  final WidgetBuilder? builder;
  final String? url;

  bool get isExternal => url != null;
}
