import 'package:flutter/cupertino.dart';

import '../app/ios.dart';
import '../app/widgets/reveal.dart';
import '../content.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Приложение «Опыт»: места работы и учёбы секциями.
class ExperienceApp extends StatelessWidget {
  const ExperienceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: Content.appExperience,
      children: [
        for (final (i, job) in Content.experience.indexed)
          Reveal(
            index: i,
            child: IosSection(
              header: job.period,
              first: i == 0,
              children: [
                IosRow(
                  title: job.company,
                  titleStyle: context.text.headline,
                  subtitle: job.position,
                  detail: job.text,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
