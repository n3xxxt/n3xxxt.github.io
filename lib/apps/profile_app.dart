import 'package:flutter/cupertino.dart';

import '../app/ios.dart';
import '../app/widgets/reveal.dart';
import '../content.dart';
import 'widgets/app_page.dart';
import 'widgets/ios_list.dart';

/// Приложение «Обо мне»: фото, краткое описание и подход.
class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final text = context.text;
    return AppPage(
      title: Content.appProfile,
      children: [
        const SizedBox(height: 8),
        const Reveal(child: Center(child: _Photo())),
        const SizedBox(height: 16),
        Reveal(
          index: 1,
          child: Text(
            Content.name,
            textAlign: TextAlign.center,
            style: text.title1.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          Content.role,
          textAlign: TextAlign.center,
          style: text.subheadline.copyWith(color: ios.secondaryLabel),
        ),
        const SizedBox(height: 2),
        Text(
          Content.location,
          textAlign: TextAlign.center,
          style: text.footnote.copyWith(color: ios.secondaryLabel),
        ),
        Reveal(
          index: 2,
          child: IosSection(
            children: [
              IosRow(
                title: Content.pitch,
                titleStyle: text.body.copyWith(fontWeight: FontWeight.w600),
                detail: Content.about,
              ),
            ],
          ),
        ),
        const _Approach(),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo();

  @override
  Widget build(BuildContext context) {
    final ios = context.ios;
    final placeholder = ColoredBox(
      color: ios.tertiarySystemFill,
      child: Center(
        child: Icon(
          CupertinoIcons.person_fill,
          size: 40,
          color: ios.secondaryLabel,
        ),
      ),
    );
    return SizedBox(
      width: 120,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            Content.photoUrl,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stack) => placeholder,
            loadingBuilder: (context, child, progress) =>
                progress == null ? child : placeholder,
          ),
        ),
      ),
    );
  }
}

class _Approach extends StatefulWidget {
  const _Approach();

  @override
  State<_Approach> createState() => _ApproachState();
}

class _ApproachState extends State<_Approach> {
  int _open = 0;

  @override
  Widget build(BuildContext context) {
    final tint = context.ios.tint;
    return IosSection(
      header: Content.sectionApproach,
      children: [
        for (final (i, s) in Content.strengths.indexed)
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: IosRow(
              title: s.title,
              subtitle: _open == i ? s.text : null,
              onTap: () => setState(() => _open = _open == i ? -1 : i),
              trailingAtTitle: true,
              trailing: TweenAnimationBuilder<double>(
                tween: Tween(end: _open == i ? 0.25 : 0),
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                builder: (context, turns, child) => RotationTransition(
                  turns: AlwaysStoppedAnimation(turns),
                  child: child,
                ),
                child: Icon(
                  CupertinoIcons.chevron_forward,
                  size: 16,
                  color: tint,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
