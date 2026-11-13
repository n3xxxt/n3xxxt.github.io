import 'package:card_app/app/ios.dart';
import 'package:card_app/app/theme.dart';
import 'package:card_app/apps/case_detail_page.dart';
import 'package:card_app/apps/cases_app.dart';
import 'package:card_app/apps/contacts_app.dart';
import 'package:card_app/apps/experience_app.dart';
import 'package:card_app/apps/profile_app.dart';
import 'package:card_app/apps/skills_app.dart';
import 'package:card_app/content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

const _small = Size(320, 693);
const _large = Size(393, 852);

Future<void> _pump(
  WidgetTester tester,
  Widget app, [
  Size size = _large,
]) async {
  GoogleFonts.config.allowRuntimeFetching = false;
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(useGoogleFonts: false),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(padding: const EdgeInsets.only(top: 54, bottom: 34)),
        child: child!,
      ),
      home: app,
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  const apps = <String, Widget>{
    Content.appProfile: ProfileApp(),
    Content.appCases: CasesApp(),
    Content.appExperience: ExperienceApp(),
    Content.appSkills: SkillsApp(),
    Content.appContacts: ContactsApp(),
  };

  for (final entry in apps.entries) {
    testWidgets('${entry.key} shows large title', (tester) async {
      await _pump(tester, entry.value);
      expect(find.text(entry.key), findsWidgets);
    });

    for (final size in [_small, _large]) {
      testWidgets('${entry.key} has no overflow at $size', (tester) async {
        await _pump(tester, entry.value, size);
        expect(tester.takeException(), isNull);
      });
    }
  }

  testWidgets('cases: detail opens and back returns', (tester) async {
    await _pump(tester, const CasesApp());
    final first = Content.cases.first;
    await tester.tap(find.text(first.title));
    await tester.pumpAndSettle();
    expect(find.text(Content.caseTask.toUpperCase()), findsOneWidget);
    expect(find.text(first.task), findsOneWidget);
    await tester.tap(find.byType(CupertinoNavigationBarBackButton));
    await tester.pumpAndSettle();
    expect(find.text(first.task), findsNothing);
    expect(find.text(first.title), findsOneWidget);
  });

  for (final size in [_small, _large]) {
    testWidgets('case detail has no overflow at $size', (tester) async {
      await _pump(tester, CaseDetailPage(study: Content.cases.first), size);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('case detail uses inline navigation bar', (tester) async {
    await _pump(tester, CaseDetailPage(study: Content.cases.first));
    expect(find.byType(CupertinoNavigationBar), findsOneWidget);
    expect(find.byType(CupertinoSliverNavigationBar), findsNothing);
  });

  testWidgets('row press highlights without ripple', (tester) async {
    await _pump(tester, const CasesApp());
    final gesture = await tester.startGesture(
      tester.getCenter(find.text(Content.cases.first.title)),
    );
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(InkWell), findsNothing);
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is ColoredBox &&
            w.color == AppTheme.light().extension<IosColors>()!.cellHighlight,
      ),
      findsOneWidget,
    );
    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('profile: second strength expands', (tester) async {
    await _pump(tester, const ProfileApp());
    final second = Content.strengths[1];
    await tester.scrollUntilVisible(find.text(second.title), 200);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -150));
    await tester.pumpAndSettle();
    expect(find.text(second.text), findsNothing);
    await tester.tap(find.text(second.title));
    await tester.pumpAndSettle();
    expect(find.text(second.text), findsOneWidget);
  });

  testWidgets('skills: segment switches list', (tester) async {
    await _pump(tester, const SkillsApp());
    final groups = Content.skills;
    expect(find.text(groups[0].items.first), findsOneWidget);
    await tester.tap(find.text(groups[1].title.split(' ').first));
    await tester.pumpAndSettle();
    expect(find.text(groups[0].items.first), findsNothing);
    expect(find.text(groups[1].items.first), findsOneWidget);
  });

  testWidgets('contacts: all labels shown, copy shows toast', (tester) async {
    await _pump(tester, const ContactsApp());
    for (final link in Content.contacts) {
      expect(find.text(link.label), findsOneWidget);
    }
    await tester.runAsync(() async {
      await tester.tap(find.byIcon(CupertinoIcons.doc_on_doc).first);
      await Future<void>.delayed(const Duration(milliseconds: 50));
    });
    await tester.pump(const Duration(milliseconds: 300));
    final opacity = tester.widget<AnimatedOpacity>(
      find.ancestor(
        of: find.text(Content.copied),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(opacity.opacity, 1);
    await tester.pumpAndSettle(const Duration(seconds: 2));
  });
}
