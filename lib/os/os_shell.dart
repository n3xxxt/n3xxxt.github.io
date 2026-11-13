import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';

import '../app/ios.dart';
import '../app/widgets/link_launcher.dart';
import '../content.dart';
import 'app_launcher.dart';
import 'frame.dart';
import 'home_indicator.dart';
import 'home_screen.dart';
import 'lock_screen.dart';
import 'phone_app.dart';
import 'status_bar.dart';
import 'wallpaper.dart';

/// Корень «операционки»: обои, экран блокировки, рабочий стол и приложения.
class OsShell extends StatefulWidget {
  const OsShell({super.key});

  @override
  State<OsShell> createState() => _OsShellState();
}

class _OsShellState extends State<OsShell> with TickerProviderStateMixin {
  late final AnimationController _unlock = AnimationController(vsync: this);
  late final AnimationController _open = AnimationController(vsync: this);
  late final AnimationController _dragCtl = AnimationController.unbounded(
    vsync: this,
  );
  final _stackKey = GlobalKey();
  PhoneApp? _app;
  Rect _from = Rect.zero;
  double _radius = 0;
  double _lockDrag = 0;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _open.addStatusListener((status) {
      final done =
          status == AnimationStatus.dismissed ||
          (status == AnimationStatus.completed && _closing);
      if (done && _app != null) {
        _dragCtl.value = 0;
        _closing = false;
        setState(() => _app = null);
      }
    });
  }

  @override
  void dispose() {
    _unlock.dispose();
    _open.dispose();
    _dragCtl.dispose();
    super.dispose();
  }

  Duration _d(int ms) => MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : Duration(milliseconds: ms);

  Size _size = Size.zero;

  double get _height => _size.height;

  void _unlockNow() {
    if (_unlock.value >= 1) return;
    _unlock.animateTo(1, duration: _d(550), curve: Curves.easeOutCubic);
  }

  void _lockDragUpdate(DragUpdateDetails d) {
    _lockDrag = math.max(0, _lockDrag - d.delta.dy);
    _unlock.value = (_lockDrag / _height).clamp(0.0, 1.0);
  }

  void _lockDragEnd(DragEndDetails d) {
    final fling = d.velocity.pixelsPerSecond.dy < -700;
    final go = _lockDrag > 80 || fling;
    _lockDrag = 0;
    if (go) {
      _unlockNow();
    } else {
      _unlock.animateTo(0, duration: _d(300), curve: Curves.easeOutCubic);
    }
  }

  void _launch(PhoneApp app, Rect globalRect, double radius) {
    if (app.isExternal) {
      openLink(app.url!);
      return;
    }
    if (_app != null) return;
    _open.value = 0;
    final box = _stackKey.currentContext!.findRenderObject()! as RenderBox;
    setState(() {
      _app = app;
      _radius = radius;
      _from = Rect.fromPoints(
        box.globalToLocal(globalRect.topLeft),
        box.globalToLocal(globalRect.bottomRight),
      );
    });
    _closing = false;
    _dragCtl.value = 0;
    if (MediaQuery.disableAnimationsOf(context)) {
      _open.value = 1;
      return;
    }
    _open.animateWith(_spring(0, 1, 260, 0.88, 0));
  }

  SpringSimulation _spring(
    double from,
    double to,
    double stiffness,
    double ratio,
    double velocity,
  ) => SpringSimulation(
    SpringDescription.withDampingRatio(
      mass: 1,
      stiffness: stiffness,
      ratio: ratio,
    ),
    from,
    to,
    velocity,
  );

  void _close([double velocity = 0]) {
    if (_app == null || _closing) return;
    _closing = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _open.value = 0;
      return;
    }
    _open.animateWith(_spring(_open.value, 0, 220, 1, velocity));
  }

  void _appDragStart(DragStartDetails d) {
    if (_closing) return;
    _dragCtl.stop();
  }

  void _appDragUpdate(DragUpdateDetails d) {
    if (_closing) return;
    _dragCtl.value = math.max(0, _dragCtl.value - d.delta.dy);
  }

  void _appDragEnd(DragEndDetails d) {
    if (_closing) return;
    final vy = d.velocity.pixelsPerSecond.dy;
    final go = _dragCtl.value > 60 || vy < -700;
    if (go) {
      _close((vy / _height).clamp(-4.0, 0.0));
    } else {
      _dragCtl.animateWith(_spring(_dragCtl.value, 0, 260, 1, -vy));
    }
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    if (_app != null) {
      if (key == LogicalKeyboardKey.escape) {
        _close();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (_unlock.value < 1 &&
        (key == LogicalKeyboardKey.enter ||
            key == LogicalKeyboardKey.numpadEnter ||
            key == LogicalKeyboardKey.space ||
            key == LogicalKeyboardKey.arrowUp)) {
      _unlockNow();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = constraints.biggest;
        return _content(context);
      },
    );
  }

  Widget _content(BuildContext context) {
    final mq = MediaQuery.of(context);
    final framed = isFramed();
    final insets = framed
        ? const EdgeInsets.only(top: 54, bottom: 34)
        : EdgeInsets.only(
            top: mq.padding.top,
            bottom: math.max(mq.padding.bottom, 20),
          );
    final size = _size;
    final both = Listenable.merge([_open, _unlock]);
    final dark = Theme.of(context).brightness == Brightness.dark;
    Color barColor() => Color.lerp(
      dark ? Colors.white : const Color(0xFF3D2216),
      context.ios.label,
      ((_open.value - 0.5) * 4).clamp(0.0, 1.0),
    )!;

    return ScrollConfiguration(
      behavior: const _OsScrollBehavior(),
      child: Focus(
        autofocus: true,
        onKeyEvent: _onKey,
        child: Stack(
          key: _stackKey,
          fit: StackFit.expand,
          children: [
            const Wallpaper(),
            AnimatedBuilder(
              animation: both,
              child: RepaintBoundary(
                child: HomeScreen(
                  reveal: _unlock,
                  insets: insets,
                  onLaunch: _launch,
                ),
              ),
              builder: (context, home) {
                final c = _open.value.clamp(0.0, 1.0);
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    IgnorePointer(
                      ignoring: _app != null || _unlock.value < 1,
                      child: Transform.scale(scale: 1 - 0.08 * c, child: home),
                    ),
                    IgnorePointer(
                      child: ColoredBox(
                        color: Colors.black.withValues(alpha: 0.25 * c),
                      ),
                    ),
                  ],
                );
              },
            ),
            if (_app != null)
              AppWindow(
                app: _app!,
                from: _from,
                radius: _radius,
                displayRadius: framed ? 55 : 0,
                progress: _open,
                drag: _dragCtl,
                screen: size,
                insets: insets,
              ),
            AnimatedBuilder(
              animation: _unlock,
              builder: (context, _) {
                final v = _unlock.value;
                if (v >= 1) return const SizedBox.shrink();
                return Transform.translate(
                  offset: Offset(0, -v * size.height),
                  child: Opacity(
                    opacity: (1 - v * 1.3).clamp(0.0, 1.0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _unlockNow,
                      onVerticalDragUpdate: _lockDragUpdate,
                      onVerticalDragEnd: _lockDragEnd,
                      child: LockScreen(insets: insets, pointer: framed),
                    ),
                  ),
                );
              },
            ),
            if (framed)
              AnimatedBuilder(
                animation: _open,
                builder: (context, _) => Positioned(
                  top: 11,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(child: OsStatusBar(color: barColor())),
                ),
              ),
            if (framed)
              const Positioned(
                top: 11,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                      ),
                      child: SizedBox(width: 124, height: 36),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedBuilder(
                animation: _open,
                builder: (context, _) => Center(
                  child: IgnorePointer(
                    ignoring: _app == null,
                    child: Tooltip(
                      message: Content.homeIndicatorLabel,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _close,
                        onVerticalDragStart: _appDragStart,
                        onVerticalDragUpdate: _appDragUpdate,
                        onVerticalDragEnd: _appDragEnd,
                        child: SizedBox(
                          width: 160,
                          height: 28,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: HomeIndicatorBar(color: barColor()),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OsScrollBehavior extends MaterialScrollBehavior {
  const _OsScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
