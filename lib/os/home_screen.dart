import 'package:flutter/material.dart';

import '../app/ios.dart';
import '../content.dart';
import 'app_icon.dart';
import 'glass.dart';
import 'registry.dart';

/// Рабочий стол: виджет-визитка, сетка иконок и док.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.reveal,
    required this.insets,
    required this.onLaunch,
  });

  final Animation<double> reveal;
  final EdgeInsets insets;
  final AppLaunch onLaunch;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    const size = IosMetrics.iconSize;
    final rows = <Widget>[];
    for (var i = 0; i < homeApps.length; i += 4) {
      final slice = homeApps.skip(i).take(4).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              for (var j = 0; j < 4; j++)
                Expanded(
                  child: j < slice.length
                      ? Center(
                          child: _Reveal(
                            index: 1 + i + j,
                            reveal: reveal,
                            child: AppIcon(
                              app: slice[j],
                              size: size,
                              onLaunch: onLaunch,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
            ],
          ),
        ),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            IosMetrics.homeSideInset,
            insets.top + 16,
            IosMetrics.homeSideInset,
            0,
          ),
          child: Column(
            children: [
              _Reveal(index: 0, reveal: reveal, child: const _CardWidget()),
              const SizedBox(height: 20),
              ...rows,
            ],
          ),
        ),
        Positioned(
          left: _dockInset,
          right: _dockInset,
          bottom: IosMetrics.dockBottom,
          height: IosMetrics.dockHeight,
          child: _Reveal(
            index: 9,
            reveal: reveal,
            child: GlassCard(
              radius: 34,
              color: Colors.white.withValues(alpha: dark ? 0.12 : 0.30),
              border: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              padding: const EdgeInsets.symmetric(
                horizontal: IosMetrics.homeSideInset - _dockInset,
              ),
              child: Row(
                children: [
                  for (final app in dockApps)
                    Expanded(
                      child: Center(
                        child: AppIcon(
                          app: app,
                          size: size,
                          onLaunch: onLaunch,
                          showLabel: false,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const _dockInset = 12.0;

class _Reveal extends StatelessWidget {
  const _Reveal({
    required this.index,
    required this.reveal,
    required this.child,
  });

  final int index;
  final Animation<double> reveal;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: reveal,
      child: child,
      builder: (context, child) {
        final p = ((reveal.value - 0.1 - index * 0.04) / 0.35).clamp(0.0, 1.0);
        return Opacity(
          opacity: p,
          child: Transform.scale(
            scale: 1.08 - 0.08 * Curves.easeOut.transform(p),
            child: child,
          ),
        );
      },
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget();

  static const _poster = Color(0xFF2B2124);
  static const _photoWidth = 170.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.ios;
    final text = context.text;
    final dim = Colors.white.withValues(alpha: 0.72);
    return Center(
      child: SizedBox.fromSize(
        size: IosMetrics.widgetSize,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(IosMetrics.widgetRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const ColoredBox(color: _poster),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                width: _photoWidth,
                child: Image.network(
                  Content.photoCardUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stack) =>
                      const SizedBox.shrink(),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    stops: const [0.5, 0.6],
                    colors: [_poster, _poster.withValues(alpha: 0)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Content.widgetCaption.toUpperCase(),
                      maxLines: 1,
                      style: text.caption1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: dim,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Content.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text.title3.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            Content.role,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: text.footnote.copyWith(color: dim),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: colors.systemGreen,
                                  shape: BoxShape.circle,
                                ),
                                child: const SizedBox(width: 8, height: 8),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  Content.widgetStatus,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: text.footnote.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
