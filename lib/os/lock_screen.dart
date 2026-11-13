import 'package:flutter/material.dart';

import '../app/ios.dart';
import '../content.dart';
import 'app_icon.dart';
import 'clock.dart';
import 'glass.dart';
import 'registry.dart';

const _lightInk = Color(0xFF3D2216);

/// Экран блокировки: дата, время, уведомления и подсказка.
class LockScreen extends StatelessWidget {
  const LockScreen({super.key, required this.insets, required this.pointer});

  final EdgeInsets insets;
  final bool pointer;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final text = context.text;
    final ink = dark ? Colors.white : _lightInk;
    final shadows = dark
        ? const [Shadow(color: Colors.black26, blurRadius: 10)]
        : const <Shadow>[];
    return Padding(
      padding: EdgeInsets.fromLTRB(0, insets.top + 18, 0, insets.bottom + 8),
      child: Column(
        children: [
          Clock(
            builder: (context, now) {
              final date =
                  '${Content.weekdays[now.weekday - 1]}, ${now.day} '
                  '${Content.monthsGenitive[now.month - 1]}';
              final time =
                  '${now.hour.toString().padLeft(2, '0')}:'
                  '${now.minute.toString().padLeft(2, '0')}';
              return Column(
                children: [
                  Text(
                    date,
                    style: text.title3.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ink.withValues(alpha: 0.85),
                      shadows: shadows,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      time,
                      style: text.largeTitle.copyWith(
                        fontSize: 96,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -2,
                        height: 1.0,
                        fontFeatures: const [FontFeature.tabularFigures()],
                        color: ink,
                        shadows: shadows,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: IosMetrics.notificationInset,
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < Content.notifications.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _NotificationCard(Content.notifications[i]),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _PulsingHint(
            pointer ? Content.unlockHintPointer : Content.unlockHint,
            color: ink,
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard(this.notification);

  final PhoneNotification notification;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final palette = dark ? IosColors.dark : IosColors.light;
    final primary = dark ? Colors.white : palette.label;
    final text = context.text;
    final matches = homeApps.where((a) => a.label == notification.app);
    final app = matches.isEmpty ? null : matches.first;
    return SizedBox(
      width: double.infinity,
      child: GlassCard(
        radius: IosMetrics.notificationRadius,
        color: dark
            ? const Color(0xFF1C1C1E).withValues(alpha: 0.6)
            : Colors.white.withValues(alpha: 0.55),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (app != null)
              AppGlyph(app: app, size: 38, radius: 8.5)
            else
              DecoratedBox(
                decoration: ShapeDecoration(
                  color: palette.tint,
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(8.5),
                  ),
                ),
                child: SizedBox(
                  width: 38,
                  height: 38,
                  child: Center(
                    child: Text(
                      notification.app.substring(0, 1),
                      style: text.headline.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.subheadline.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        notification.age,
                        style: text.footnote.copyWith(
                          color: palette.secondaryLabel,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    notification.text,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: text.subheadline.copyWith(
                      fontWeight: FontWeight.w400,
                      color: primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingHint extends StatefulWidget {
  const _PulsingHint(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  State<_PulsingHint> createState() => _PulsingHintState();
}

class _PulsingHintState extends State<_PulsingHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 1;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.45,
        end: 1,
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: Text(
        widget.text,
        textAlign: TextAlign.center,
        style: context.text.subheadline.copyWith(
          fontWeight: FontWeight.w500,
          color: widget.color,
        ),
      ),
    );
  }
}
