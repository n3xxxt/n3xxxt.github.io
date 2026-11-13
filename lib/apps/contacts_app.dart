import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../app/ios.dart';
import '../app/widgets/link_launcher.dart';
import '../app/widgets/reveal.dart';
import '../content.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Приложение «Связь»: список контактов с копированием.
class ContactsApp extends StatefulWidget {
  const ContactsApp({super.key});

  @override
  State<ContactsApp> createState() => _ContactsAppState();
}

class _ContactsAppState extends State<ContactsApp> {
  Timer? _timer;
  bool _toast = false;

  Future<void> _copy(String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!mounted) return;
    setState(() => _toast = true);
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 1600), () {
      if (mounted) setState(() => _toast = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Stack(
      children: [
        AppPage(
          title: Content.appContacts,
          children: [
            Reveal(
              child: IosSection(
                first: true,
                description: Content.contactsSubtitle,
                children: [
                  for (final link in Content.contacts)
                    _ContactRow(link: link, onCopy: _copy),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottom + 16,
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: _toast ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: ios.label.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Text(
                      Content.copied,
                      style: context.text.subheadline.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ios.systemBackground,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.link, required this.onCopy});

  final Link link;
  final Future<void> Function(String value) onCopy;

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final copyValue = link.copyValue;
    return IosRow(
      overline: link.caption,
      overlineStyle: context.text.subheadline,
      title: link.label,
      titleColor: ios.tint,
      onTap: () => openLink(link.url),
      trailing: copyValue == null
          ? null
          : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onCopy(copyValue),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Icon(
                  CupertinoIcons.doc_on_doc,
                  size: 20,
                  color: ios.tint,
                ),
              ),
            ),
    );
  }
}
