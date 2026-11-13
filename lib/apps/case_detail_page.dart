import 'package:flutter/cupertino.dart';

import '../app/ios.dart';
import '../app/widgets/link_launcher.dart';
import '../app/widgets/reveal.dart';
import '../content.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Детальный экран кейса внутри приложения «Кейсы».
class CaseDetailPage extends StatelessWidget {
  const CaseDetailPage({super.key, required this.study});

  final CaseStudy study;

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final text = context.text;
    return AppPage(
      largeTitle: false,
      title: study.label,
      previousPageTitle: Content.appCases,
      children: [
        const SizedBox(height: 8),
        Text(
          study.title,
          style: text.title2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          study.role,
          style: text.subheadline.copyWith(color: ios.secondaryLabel),
        ),
        Reveal(
          index: 1,
          child: IosSection(
            header: Content.caseTask,
            children: [IosRow(title: study.task)],
          ),
        ),
        Reveal(
          index: 2,
          child: IosSection(
            header: Content.caseDone,
            children: [IosRow(title: study.done)],
          ),
        ),
        Reveal(
          index: 3,
          child: IosSection(
            header: Content.caseResult,
            children: [IosRow(title: study.result)],
          ),
        ),
        if (study.links.isNotEmpty)
          Reveal(
            index: 4,
            child: IosSection(
              children: [
                for (final link in study.links)
                  IosRow(
                    title: link.label,
                    titleColor: ios.tint,
                    trailing: Icon(
                      CupertinoIcons.arrow_up_right,
                      size: 15,
                      color: ios.tint,
                    ),
                    onTap: () => openLink(link.url),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
