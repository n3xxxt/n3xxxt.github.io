import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/ios.dart';

/// Страница приложения с iOS-навигацией и отскоком.
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.title,
    required this.children,
    this.previousPageTitle,
    this.largeTitle = true,
  });

  final String title;
  final String? previousPageTitle;
  final bool largeTitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final padding = MediaQuery.paddingOf(context);
    final border = Border(
      bottom: BorderSide(
        color: ios.separator,
        width: IosMetrics.separatorWidth,
      ),
    );
    final content = SliverPadding(
      padding: EdgeInsets.fromLTRB(
        IosMetrics.inset,
        largeTitle ? 0 : padding.top + kMinInteractiveDimensionCupertino,
        IosMetrics.inset,
        padding.bottom + IosMetrics.sectionSpacing,
      ),
      sliver: SliverList.list(children: children),
    );
    final scroll = CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        if (largeTitle)
          CupertinoSliverNavigationBar(
            largeTitle: Text(title),
            previousPageTitle: previousPageTitle,
            border: border,
            enableBackgroundFilterBlur: false,
          ),
        content,
      ],
    );
    return ScrollNotificationObserver(
      child: Material(
        type: MaterialType.transparency,
        child: CupertinoPageScaffold(
          backgroundColor: ios.systemGroupedBackground,
          navigationBar: largeTitle
              ? null
              : CupertinoNavigationBar(
                  middle: Text(title),
                  previousPageTitle: previousPageTitle,
                  border: border,
                  enableBackgroundFilterBlur: false,
                ),
          child: scroll,
        ),
      ),
    );
  }
}
