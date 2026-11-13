import 'package:flutter/cupertino.dart';

import '../app/ios.dart';
import '../content.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Приложение «Навыки»: группы компетенций с переключателем.
class SkillsApp extends StatefulWidget {
  const SkillsApp({super.key});

  @override
  State<SkillsApp> createState() => _SkillsAppState();
}

class _SkillsAppState extends State<SkillsApp> {
  int _group = 0;

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final group = Content.skills[_group];
    return AppPage(
      title: Content.appSkills,
      children: [
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<int>(
            groupValue: _group,
            backgroundColor: ios.tertiarySystemFill,
            thumbColor: ios.segmentThumb,
            onValueChanged: (v) => setState(() => _group = v ?? _group),
            children: {
              for (final (i, g) in Content.skills.indexed)
                i: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      g.title.split(' ').first,
                      style: context.text.footnote.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            },
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(
            key: ValueKey(_group),
            child: IosSection(
              header: group.title,
              children: [for (final item in group.items) IosRow(title: item)],
            ),
          ),
        ),
      ],
    );
  }
}
