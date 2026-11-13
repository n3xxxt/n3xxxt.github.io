import 'package:flutter/cupertino.dart';

import '../app/ios.dart';
import '../app/widgets/reveal.dart';
import '../content.dart';
import 'case_detail_page.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Приложение «Кейсы» со своей вложенной навигацией.
class CasesApp extends StatelessWidget {
  const CasesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) =>
          CupertinoPageRoute<void>(builder: (_) => const _CasesList()),
    );
  }
}

class _CasesList extends StatelessWidget {
  const _CasesList();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: Content.appCases,
      children: [
        Reveal(
          child: IosSection(
            first: true,
            description: Content.casesSubtitle,
            children: [
              for (final study in Content.cases)
                IosRow(
                  overline: study.label,
                  title: study.title,
                  titleStyle: context.text.headline,
                  subtitle: study.role,
                  chevron: true,
                  onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute<void>(
                      builder: (_) => CaseDetailPage(study: study),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
