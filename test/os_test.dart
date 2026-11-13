import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:card_app/content.dart';
import 'package:card_app/main.dart';
import 'package:card_app/os/registry.dart';

Future<void> _pump(WidgetTester tester, Size size) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(const PhoneOS(useGoogleFonts: false));
  await tester.pump();
}

Future<void> _unlock(WidgetTester tester) async {
  await tester.drag(
    find.text(Content.notifications.first.title),
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> _dispose(WidgetTester tester) =>
    tester.pumpWidget(const SizedBox.shrink());

void main() {
  const phone = Size(393, 852);

  testWidgets('старт: экран блокировки с уведомлениями', (tester) async {
    await _pump(tester, phone);
    for (final n in Content.notifications) {
      expect(find.text(n.title), findsOneWidget);
    }
    expect(find.text(Content.unlockHint), findsOneWidget);
    await _dispose(tester);
  });

  testWidgets('drag вверх открывает рабочий стол', (tester) async {
    await _pump(tester, phone);
    await _unlock(tester);
    for (final app in homeApps) {
      expect(find.text(app.label), findsWidgets);
    }
    expect(find.text(Content.notifications.first.title), findsNothing);
    await _dispose(tester);
  });

  testWidgets('клавиша Enter разблокирует', (tester) async {
    await _pump(tester, phone);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text(Content.notifications.first.title), findsNothing);
    await _dispose(tester);
  });

  testWidgets('приложение открывается и закрывается', (tester) async {
    await _pump(tester, phone);
    await _unlock(tester);
    await tester.tap(find.text(Content.appProfile));
    await tester.pumpAndSettle();
    expect(find.byType(CustomScrollView), findsOneWidget);
    expect(find.text(Content.appProfile), findsWidgets);

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsNothing);

    await tester.tap(find.text(Content.appProfile));
    await tester.pumpAndSettle();
    expect(find.byType(CustomScrollView), findsOneWidget);
    await tester.tap(find.byTooltip(Content.homeIndicatorLabel));
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsNothing);
    await _dispose(tester);
  });

  for (final size in const [Size(320, 693), Size(393, 852)]) {
    testWidgets('нет overflow на $size', (tester) async {
      await _pump(tester, size);
      await _unlock(tester);
      await tester.tap(find.text(Content.appProfile));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await _dispose(tester);
    });

    testWidgets('нет overflow на экране блокировки $size', (tester) async {
      await _pump(tester, size);
      expect(tester.takeException(), isNull);
      await _dispose(tester);
    });
  }
}
