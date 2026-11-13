import 'package:flutter/cupertino.dart';

import '../apps/cases_app.dart';
import '../apps/contacts_app.dart';
import '../apps/experience_app.dart';
import '../apps/profile_app.dart';
import '../apps/skills_app.dart';
import '../content.dart';
import 'phone_app.dart';

final _profile = PhoneApp(
  id: 'profile',
  label: Content.appProfile,
  icon: CupertinoIcons.person_crop_circle_fill,
  colors: const [Color(0xFFF4F4F6), Color(0xFFD5D5DA)],
  glyphColor: Color(0xFF8E8E93),
  builder: (_) => const ProfileApp(),
);

final _cases = PhoneApp(
  id: 'cases',
  label: Content.appCases,
  icon: CupertinoIcons.briefcase_fill,
  colors: const [Color(0xFFFFB547), Color(0xFFFF8A1F)],
  builder: (_) => const CasesApp(),
);

final _experience = PhoneApp(
  id: 'experience',
  label: Content.appExperience,
  icon: CupertinoIcons.clock_fill,
  colors: const [Color(0xFF7D7AFF), Color(0xFF5856D6)],
  builder: (_) => const ExperienceApp(),
);

final _skills = PhoneApp(
  id: 'skills',
  label: Content.appSkills,
  icon: CupertinoIcons.gear_alt_fill,
  colors: const [Color(0xFFA5A5AB), Color(0xFF6E6E74)],
  builder: (_) => const SkillsApp(),
);

final _contacts = PhoneApp(
  id: 'contacts',
  label: Content.appContacts,
  icon: CupertinoIcons.chat_bubble_fill,
  colors: const [Color(0xFF5CF777), Color(0xFF0EBE2C)],
  builder: (_) => const ContactsApp(),
);

const _mail = PhoneApp(
  id: 'mail',
  label: Content.appMail,
  icon: CupertinoIcons.mail_solid,
  colors: [Color(0xFF21A0FF), Color(0xFF0A63F2)],
  url: 'mailto:notdonebyone@internet.ru',
);

const _shotscope = PhoneApp(
  id: 'shotscope',
  label: Content.appShotscope,
  icon: CupertinoIcons.scope,
  colors: [Color(0xFFFF8A5C), Color(0xFFC8401C)],
  url: 'https://shotscope.ru',
);

const _team = PhoneApp(
  id: 'team',
  label: Content.appTeam,
  icon: CupertinoIcons.person_3_fill,
  colors: [Color(0xFF3A3A40), Color(0xFF141416)],
  url: 'https://notdonebyone.ru',
);

const _github = PhoneApp(
  id: 'github',
  label: Content.appGithub,
  icon: CupertinoIcons.chevron_left_slash_chevron_right,
  colors: [Color(0xFF4A4A50), Color(0xFF1C1C1F)],
  url: 'https://github.com/n3xxxt',
);

/// Иконки рабочего стола.
final homeApps = <PhoneApp>[
  _profile,
  _cases,
  _experience,
  _skills,
  _contacts,
  _shotscope,
  _team,
  _github,
];

/// Иконки дока.
final dockApps = <PhoneApp>[_profile, _cases, _contacts, _mail];
