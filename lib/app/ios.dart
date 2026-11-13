import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Системные цвета iOS для светлой и тёмной темы.
@immutable
class IosColors extends ThemeExtension<IosColors> {
  const IosColors({
    required this.systemBackground,
    required this.systemGroupedBackground,
    required this.secondarySystemGroupedBackground,
    required this.tertiarySystemGroupedBackground,
    required this.label,
    required this.secondaryLabel,
    required this.tertiaryLabel,
    required this.quaternaryLabel,
    required this.separator,
    required this.opaqueSeparator,
    required this.systemFill,
    required this.tertiarySystemFill,
    required this.cellHighlight,
    required this.segmentThumb,
    required this.systemGreen,
    required this.tint,
  });

  static const light = IosColors(
    systemBackground: Color(0xFFFFFFFF),
    systemGroupedBackground: Color(0xFFF2F2F7),
    secondarySystemGroupedBackground: Color(0xFFFFFFFF),
    tertiarySystemGroupedBackground: Color(0xFFF2F2F7),
    label: Color(0xFF000000),
    secondaryLabel: Color(0x993C3C43),
    tertiaryLabel: Color(0x4D3C3C43),
    quaternaryLabel: Color(0x2E3C3C43),
    separator: Color(0x4A3C3C43),
    opaqueSeparator: Color(0xFFC6C6C8),
    systemFill: Color(0x33787880),
    tertiarySystemFill: Color(0x1F767680),
    cellHighlight: Color(0xFFD1D1D6),
    segmentThumb: Color(0xFFFFFFFF),
    systemGreen: Color(0xFF34C759),
    tint: Color(0xFFC8401C),
  );

  static const dark = IosColors(
    systemBackground: Color(0xFF000000),
    systemGroupedBackground: Color(0xFF000000),
    secondarySystemGroupedBackground: Color(0xFF1C1C1E),
    tertiarySystemGroupedBackground: Color(0xFF2C2C2E),
    label: Color(0xFFFFFFFF),
    secondaryLabel: Color(0x99EBEBF5),
    tertiaryLabel: Color(0x4DEBEBF5),
    quaternaryLabel: Color(0x29EBEBF5),
    separator: Color(0x99545458),
    opaqueSeparator: Color(0xFF38383A),
    systemFill: Color(0x5C787880),
    tertiarySystemFill: Color(0x3D767680),
    cellHighlight: Color(0xFF3A3A3C),
    segmentThumb: Color(0xFF636366),
    systemGreen: Color(0xFF30D158),
    tint: Color(0xFFF06A3F),
  );

  final Color systemBackground;
  final Color systemGroupedBackground;
  final Color secondarySystemGroupedBackground;
  final Color tertiarySystemGroupedBackground;
  final Color label;
  final Color secondaryLabel;
  final Color tertiaryLabel;
  final Color quaternaryLabel;
  final Color separator;
  final Color opaqueSeparator;
  final Color systemFill;
  final Color tertiarySystemFill;
  final Color cellHighlight;
  final Color segmentThumb;
  final Color systemGreen;
  final Color tint;

  @override
  IosColors copyWith({
    Color? systemBackground,
    Color? systemGroupedBackground,
    Color? secondarySystemGroupedBackground,
    Color? tertiarySystemGroupedBackground,
    Color? label,
    Color? secondaryLabel,
    Color? tertiaryLabel,
    Color? quaternaryLabel,
    Color? separator,
    Color? opaqueSeparator,
    Color? systemFill,
    Color? tertiarySystemFill,
    Color? cellHighlight,
    Color? segmentThumb,
    Color? systemGreen,
    Color? tint,
  }) {
    return IosColors(
      systemBackground: systemBackground ?? this.systemBackground,
      systemGroupedBackground:
          systemGroupedBackground ?? this.systemGroupedBackground,
      secondarySystemGroupedBackground:
          secondarySystemGroupedBackground ??
          this.secondarySystemGroupedBackground,
      tertiarySystemGroupedBackground:
          tertiarySystemGroupedBackground ??
          this.tertiarySystemGroupedBackground,
      label: label ?? this.label,
      secondaryLabel: secondaryLabel ?? this.secondaryLabel,
      tertiaryLabel: tertiaryLabel ?? this.tertiaryLabel,
      quaternaryLabel: quaternaryLabel ?? this.quaternaryLabel,
      separator: separator ?? this.separator,
      opaqueSeparator: opaqueSeparator ?? this.opaqueSeparator,
      systemFill: systemFill ?? this.systemFill,
      tertiarySystemFill: tertiarySystemFill ?? this.tertiarySystemFill,
      cellHighlight: cellHighlight ?? this.cellHighlight,
      segmentThumb: segmentThumb ?? this.segmentThumb,
      systemGreen: systemGreen ?? this.systemGreen,
      tint: tint ?? this.tint,
    );
  }

  @override
  IosColors lerp(ThemeExtension<IosColors>? other, double t) {
    if (other is! IosColors) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return IosColors(
      systemBackground: mix(systemBackground, other.systemBackground),
      systemGroupedBackground: mix(
        systemGroupedBackground,
        other.systemGroupedBackground,
      ),
      secondarySystemGroupedBackground: mix(
        secondarySystemGroupedBackground,
        other.secondarySystemGroupedBackground,
      ),
      tertiarySystemGroupedBackground: mix(
        tertiarySystemGroupedBackground,
        other.tertiarySystemGroupedBackground,
      ),
      label: mix(label, other.label),
      secondaryLabel: mix(secondaryLabel, other.secondaryLabel),
      tertiaryLabel: mix(tertiaryLabel, other.tertiaryLabel),
      quaternaryLabel: mix(quaternaryLabel, other.quaternaryLabel),
      separator: mix(separator, other.separator),
      opaqueSeparator: mix(opaqueSeparator, other.opaqueSeparator),
      systemFill: mix(systemFill, other.systemFill),
      tertiarySystemFill: mix(tertiarySystemFill, other.tertiarySystemFill),
      cellHighlight: mix(cellHighlight, other.cellHighlight),
      segmentThumb: mix(segmentThumb, other.segmentThumb),
      systemGreen: mix(systemGreen, other.systemGreen),
      tint: mix(tint, other.tint),
    );
  }
}

/// Шкала текстовых стилей iOS (Dynamic Type, размер по умолчанию).
@immutable
class IosText extends ThemeExtension<IosText> {
  const IosText({
    required this.largeTitle,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.headline,
    required this.body,
    required this.callout,
    required this.subheadline,
    required this.footnote,
    required this.caption1,
    required this.caption2,
  });

  /// Собирает шкалу с цветом `label` темы и шрифтом Inter при [fonts].
  factory IosText.build(IosColors c, {required bool fonts}) {
    TextStyle style(
      double size,
      double line,
      double spacing, {
      FontWeight weight = FontWeight.w400,
    }) {
      final base = TextStyle(
        fontSize: size,
        height: line / size,
        letterSpacing: spacing,
        fontWeight: weight,
        color: c.label,
      );
      return fonts ? GoogleFonts.inter(textStyle: base) : base;
    }

    return IosText(
      largeTitle: style(34, 41, 0.40, weight: FontWeight.w700),
      title1: style(28, 34, 0.38),
      title2: style(22, 28, -0.26),
      title3: style(20, 25, -0.45),
      headline: style(17, 22, -0.43, weight: FontWeight.w600),
      body: style(17, 22, -0.43),
      callout: style(16, 21, -0.31),
      subheadline: style(15, 20, -0.23),
      footnote: style(13, 18, -0.08),
      caption1: style(12, 16, 0),
      caption2: style(11, 13, 0.06),
    );
  }

  final TextStyle largeTitle;
  final TextStyle title1;
  final TextStyle title2;
  final TextStyle title3;
  final TextStyle headline;
  final TextStyle body;
  final TextStyle callout;
  final TextStyle subheadline;
  final TextStyle footnote;
  final TextStyle caption1;
  final TextStyle caption2;

  @override
  IosText copyWith({
    TextStyle? largeTitle,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? title3,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? subheadline,
    TextStyle? footnote,
    TextStyle? caption1,
    TextStyle? caption2,
  }) {
    return IosText(
      largeTitle: largeTitle ?? this.largeTitle,
      title1: title1 ?? this.title1,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      callout: callout ?? this.callout,
      subheadline: subheadline ?? this.subheadline,
      footnote: footnote ?? this.footnote,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
    );
  }

  @override
  IosText lerp(ThemeExtension<IosText>? other, double t) {
    if (other is! IosText) return this;
    TextStyle mix(TextStyle a, TextStyle b) => TextStyle.lerp(a, b, t)!;
    return IosText(
      largeTitle: mix(largeTitle, other.largeTitle),
      title1: mix(title1, other.title1),
      title2: mix(title2, other.title2),
      title3: mix(title3, other.title3),
      headline: mix(headline, other.headline),
      body: mix(body, other.body),
      callout: mix(callout, other.callout),
      subheadline: mix(subheadline, other.subheadline),
      footnote: mix(footnote, other.footnote),
      caption1: mix(caption1, other.caption1),
      caption2: mix(caption2, other.caption2),
    );
  }
}

/// Доступ к системным цветам и шкале текста iOS из контекста.
extension IosThemeContext on BuildContext {
  IosColors get ios => Theme.of(this).extension<IosColors>()!;

  IosText get text => Theme.of(this).extension<IosText>()!;
}

/// Геометрия iOS в логических пунктах канвы 393 pt.
abstract final class IosMetrics {
  static const double canvasWidth = 393;
  static const double inset = 16;
  static const double cornerRadius = 10;
  static const double rowMinHeight = 44;
  static const double separatorWidth = 0.5;
  static const double sectionSpacing = 35;
  static const double sectionHeaderGap = 7;
  static const double iconSize = 60;
  static const double homeSideInset = 27;
  static const double dockHeight = 96;
  static const double dockBottom = 12;
  static const Size widgetSize = Size(338, 158);
  static const double widgetRadius = 22;
  static const double notificationRadius = 20;
  static const double notificationInset = 8;
}
