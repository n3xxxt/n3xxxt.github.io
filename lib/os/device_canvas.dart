import 'package:flutter/widgets.dart';

import '../app/ios.dart';

/// Приводит экран телефона к логической ширине 393 pt независимо от размера рамки.
class DeviceCanvas extends StatelessWidget {
  const DeviceCanvas({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scale = constraints.maxWidth / IosMetrics.canvasWidth;
        final media = MediaQuery.of(context);
        if ((scale - 1).abs() < 0.001) return child;
        final size = Size(
          IosMetrics.canvasWidth,
          constraints.maxHeight / scale,
        );
        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox.fromSize(
            size: size,
            child: MediaQuery(
              data: media.copyWith(
                size: size,
                padding: media.padding / scale,
                viewPadding: media.viewPadding / scale,
                viewInsets: media.viewInsets / scale,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
