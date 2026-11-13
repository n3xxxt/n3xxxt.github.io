import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/ios.dart';
import 'phone_app.dart';

/// Вызывается при нажатии на иконку с её глобальным прямоугольником.
typedef AppLaunch = void Function(PhoneApp app, Rect rect, double radius);

const _radiusFactor = 0.225;

/// Иконка приложения на рабочем столе или в доке.
class AppIcon extends StatefulWidget {
  const AppIcon({
    super.key,
    required this.app,
    required this.size,
    required this.onLaunch,
    this.showLabel = true,
  });

  final PhoneApp app;
  final double size;
  final AppLaunch onLaunch;
  final bool showLabel;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  final _boxKey = GlobalKey();
  bool _pressed = false;

  double get _radius => widget.size * _radiusFactor;

  void _launch() {
    final box = _boxKey.currentContext!.findRenderObject()! as RenderBox;
    final rect = box.localToGlobal(Offset.zero) & box.size;
    widget.onLaunch(widget.app, rect, _radius);
    if (widget.app.isExternal) {
      Future<void>.delayed(const Duration(milliseconds: 160), () {
        if (mounted) setState(() => _pressed = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animate = !MediaQuery.disableAnimationsOf(context);
    final glyph = AppGlyph(key: _boxKey, app: widget.app, size: widget.size);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) {
          if (!widget.app.isExternal) setState(() => _pressed = false);
        },
        onTap: _launch,
        child: Semantics(
          button: true,
          label: widget.app.label,
          excludeSemantics: true,
          child: AnimatedScale(
            scale: _pressed ? 0.9 : 1,
            duration: animate
                ? const Duration(milliseconds: 120)
                : Duration.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                glyph,
                if (widget.showLabel) ...[
                  const SizedBox(height: 5),
                  LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.hasBoundedWidth
                          ? constraints.maxWidth
                          : widget.size,
                      child: Text(
                        widget.app.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: context.text.caption1.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Градиентная плитка приложения с глифом, без подписи и нажатия.
class AppGlyph extends StatelessWidget {
  const AppGlyph({
    super.key,
    required this.app,
    required this.size,
    this.radius,
  });

  final PhoneApp app;
  final double size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedSuperellipseBorder(
      borderRadius: BorderRadius.circular(radius ?? size * _radiusFactor),
    );
    return Container(
      width: size,
      height: size,
      decoration: ShapeDecoration(
        shape: shape,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: app.colors,
        ),
      ),
      child: Icon(
        app.icon,
        size:
            size *
            (app.icon == CupertinoIcons.person_crop_circle_fill ? 0.78 : 0.6),
        color: app.glyphColor,
      ),
    );
  }
}
