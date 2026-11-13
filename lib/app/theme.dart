import 'package:flutter/cupertino.dart'
    show CupertinoTextThemeData, CupertinoThemeData;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ios.dart';

/// Цветовые токены визитки для светлой и тёмной темы.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.bg,
    required this.surface,
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.line,
    required this.accent,
  });

  static const light = AppTokens(
    bg: Color(0xFFFBFAF8),
    surface: Color(0xFFF2F0EC),
    ink: Color(0xFF16161A),
    ink2: Color(0xFF55555C),
    ink3: Color(0xFF85858C),
    line: Color(0xFFE2DFD9),
    accent: Color(0xFFC8401C),
  );

  static const dark = AppTokens(
    bg: Color(0xFF111113),
    surface: Color(0xFF1A1A1D),
    ink: Color(0xFFEDEDEE),
    ink2: Color(0xFFA9A9B0),
    ink3: Color(0xFF77777E),
    line: Color(0xFF2A2A2E),
    accent: Color(0xFFF06A3F),
  );

  final Color bg;
  final Color surface;
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color line;
  final Color accent;

  @override
  AppTokens copyWith({
    Color? bg,
    Color? surface,
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? line,
    Color? accent,
  }) {
    return AppTokens(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      ink3: ink3 ?? this.ink3,
      line: line ?? this.line,
      accent: accent ?? this.accent,
    );
  }

  @override
  AppTokens lerp(ThemeExtension<AppTokens>? other, double t) {
    if (other is! AppTokens) return this;
    return AppTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      ink3: Color.lerp(ink3, other.ink3, t)!,
      line: Color.lerp(line, other.line, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
    );
  }
}

/// Доступ к токенам и текстовым стилям из контекста.
extension AppThemeContext on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}

/// Сборка тем приложения.
abstract final class AppTheme {
  static const double cardRadius = 16;

  static ThemeData light({bool useGoogleFonts = true}) =>
      _build(AppTokens.light, Brightness.light, useGoogleFonts);

  static ThemeData dark({bool useGoogleFonts = true}) =>
      _build(AppTokens.dark, Brightness.dark, useGoogleFonts);

  static ThemeData _build(AppTokens t, Brightness brightness, bool fonts) {
    final base = ThemeData(brightness: brightness).textTheme;
    final styled = base.copyWith(
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
        height: 1.3,
        color: t.ink3,
      ),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5, color: t.ink2),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: t.ink,
      ),
      headlineMedium: TextStyle(
        fontSize: 29,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.2,
        color: t.ink,
      ),
    );
    final textTheme = fonts ? GoogleFonts.interTextTheme(styled) : styled;
    final c = brightness == Brightness.light ? IosColors.light : IosColors.dark;
    final ios = IosText.build(c, fonts: fonts);
    final scheme =
        ColorScheme.fromSeed(
          seedColor: t.accent,
          brightness: brightness,
        ).copyWith(
          primary: t.accent,
          onPrimary: t.bg,
          surface: t.bg,
          onSurface: t.ink,
          outline: t.line,
          outlineVariant: t.line,
          surfaceContainer: t.surface,
          secondaryContainer: t.surface,
          onSecondaryContainer: t.accent,
        );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.systemGroupedBackground,
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      extensions: [t, c, ios],
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: c.tint,
        barBackgroundColor: c.systemGroupedBackground.withValues(alpha: 0.94),
        scaffoldBackgroundColor: c.systemGroupedBackground,
        textTheme: CupertinoTextThemeData(
          primaryColor: c.tint,
          textStyle: ios.body,
          actionTextStyle: ios.body.copyWith(color: c.tint),
          navTitleTextStyle: ios.headline,
          navLargeTitleTextStyle: ios.largeTitle,
          navActionTextStyle: ios.body.copyWith(color: c.tint),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: t.bg,
        surfaceTintColor: Colors.transparent,
        indicatorColor: t.surface,
        labelTextStyle: WidgetStatePropertyAll(
          textTheme.bodyLarge!.copyWith(fontSize: 12, color: t.ink2),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: t.ink,
          side: BorderSide(color: t.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: t.ink,
        contentTextStyle: TextStyle(color: t.bg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
