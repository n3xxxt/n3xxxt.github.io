import 'package:flutter/cupertino.dart';

import '../../app/ios.dart';

/// Секция inset grouped: заголовок, карточка со строками и подвал.
class IosSection extends StatelessWidget {
  const IosSection({
    super.key,
    this.header,
    this.description,
    this.footer,
    this.first = false,
    required this.children,
  });

  final String? header;
  final String? description;
  final String? footer;
  final bool first;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final text = context.text;
    final hasHead = header != null || description != null;
    final top = first
        ? 8.0
        : hasHead
        ? 22.0
        : IosMetrics.sectionSpacing;
    return Padding(
      padding: EdgeInsets.only(top: top),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (header != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                IosMetrics.inset,
                0,
                IosMetrics.inset,
                IosMetrics.sectionHeaderGap,
              ),
              child: Text(
                header!.toUpperCase(),
                style: text.footnote.copyWith(color: ios.secondaryLabel),
              ),
            ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                IosMetrics.inset,
                0,
                IosMetrics.inset,
                IosMetrics.sectionHeaderGap,
              ),
              child: Text(
                description!,
                style: text.subheadline.copyWith(color: ios.secondaryLabel),
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(IosMetrics.cornerRadius),
            child: ColoredBox(
              color: ios.secondarySystemGroupedBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (i, child) in children.indexed) ...[
                    if (i > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: IosMetrics.inset),
                        child: SizedBox(
                          height: IosMetrics.separatorWidth,
                          child: ColoredBox(color: ios.separator),
                        ),
                      ),
                    child,
                  ],
                ],
              ),
            ),
          ),
          if (footer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                IosMetrics.inset,
                IosMetrics.sectionHeaderGap,
                IosMetrics.inset,
                0,
              ),
              child: Text(
                footer!,
                style: text.footnote.copyWith(color: ios.secondaryLabel),
              ),
            ),
        ],
      ),
    );
  }
}

/// Строка списка iOS с подсветкой нажатия.
class IosRow extends StatefulWidget {
  const IosRow({
    super.key,
    this.overline,
    this.overlineStyle,
    required this.title,
    this.subtitle,
    this.detail,
    this.trailing,
    this.chevron = false,
    this.onTap,
    this.titleStyle,
    this.titleColor,
    this.trailingAtTitle = false,
  });

  final String? overline;
  final TextStyle? overlineStyle;
  final String title;
  final String? subtitle;
  final String? detail;
  final Widget? trailing;
  final bool chevron;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final bool trailingAtTitle;

  @override
  State<IosRow> createState() => _IosRowState();
}

class _IosRowState extends State<IosRow> {
  bool _pressed = false;

  void _set(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final text = context.text;
    var titleStyle = widget.titleStyle ?? text.body;
    if (widget.titleColor != null) {
      titleStyle = titleStyle.copyWith(color: widget.titleColor);
    }
    final content = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: IosMetrics.rowMinHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: IosMetrics.inset,
          vertical: 11,
        ),
        child: Row(
          crossAxisAlignment: widget.trailingAtTitle
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.overline != null) ...[
                    Text(
                      widget.overline!,
                      style:
                          widget.overlineStyle ??
                          text.footnote.copyWith(color: ios.secondaryLabel),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(widget.title, style: titleStyle),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle!,
                      style: text.subheadline.copyWith(
                        color: ios.secondaryLabel,
                      ),
                    ),
                  ],
                  if (widget.detail != null) ...[
                    const SizedBox(height: 6),
                    Text(widget.detail!, style: text.subheadline),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 8),
              if (widget.trailingAtTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: widget.trailing,
                )
              else
                widget.trailing!,
            ],
            if (widget.chevron) ...[
              const SizedBox(width: 8),
              Icon(
                CupertinoIcons.chevron_forward,
                size: 16,
                color: ios.tertiaryLabel,
              ),
            ],
          ],
        ),
      ),
    );
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        onTapDown: widget.onTap == null ? null : (_) => _set(true),
        onTapUp: widget.onTap == null ? null : (_) => _set(false),
        onTapCancel: widget.onTap == null ? null : () => _set(false),
        child: ColoredBox(
          color: _pressed
              ? ios.cellHighlight
              : ios.secondarySystemGroupedBackground,
          child: content,
        ),
      ),
    );
  }
}
