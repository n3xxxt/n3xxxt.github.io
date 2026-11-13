/// Содержимое визитки: все тексты приложения.
abstract final class Content {
  static const name = 'Андрей Никитцев';
  static const role = 'Flutter-разработчик · основатель NotDoneByOne';
  static const pitch =
      'Строю продукты, команды и процессы там, где ещё нет готовых решений.';
  static const about =
      'Разрабатываю мобильные приложения в Surf. В своей команде NotDoneByOne '
      'прошёл путь от идеи до продукта в сторе: собрал людей, процессы и '
      'инфраструктуру с нуля.';
  static const location = 'Воронеж';
  static const photoUrl = 'photo.jpg';
  static const photoCardUrl = 'photo_card.jpg';
  static const photoPlaceholder = 'Место для фото';

  static const tabProfile = 'Профиль';
  static const tabCases = 'Кейсы';
  static const tabContacts = 'Связь';

  static const sectionApproach = 'Что я привношу';
  static const sectionExperience = 'Опыт';
  static const sectionSkills = 'Компетенции';
  static const casesTitle = 'Что построено';
  static const casesSubtitle =
      'Истории о том, как я запускаю новое и довожу до рабочего состояния.';
  static const contactsTitle = 'Давайте поговорим';
  static const contactsSubtitle =
      'Открыт к разговору о работе в команде, где нужно строить новое.';
  static const caseTask = 'Задача';
  static const caseDone = 'Что сделал';
  static const caseResult = 'Результат';
  static const copied = 'Скопировано';
  static const themeToggle = 'Сменить тему';

  static const unlockHint = 'Смахните вверх, чтобы открыть';
  static const unlockHintPointer = 'Нажмите или смахните вверх, чтобы открыть';
  static const weekdays = [
    'понедельник',
    'вторник',
    'среда',
    'четверг',
    'пятница',
    'суббота',
    'воскресенье',
  ];
  static const monthsGenitive = [
    'января',
    'февраля',
    'марта',
    'апреля',
    'мая',
    'июня',
    'июля',
    'августа',
    'сентября',
    'октября',
    'ноября',
    'декабря',
  ];
  static const notificationNow = 'сейчас';

  static const notifications = <PhoneNotification>[
    PhoneNotification(
      app: 'NotDoneByOne',
      title: 'Команда собрана с нуля',
      text:
          'Flutter, бэкенд, QA и аналитика — у каждого направления свой '
          'руководитель.',
      age: '2 мин',
    ),
    PhoneNotification(
      app: 'ShotSCOPE',
      title: 'Релиз в RuStore',
      text: 'Продукт прошёл путь от идеи до стора.',
      age: '1 ч',
    ),
    PhoneNotification(
      app: 'Кейсы',
      title: 'Где нет готовых решений',
      text:
          'Новый продукт, новая команда, процесс, который предстоит '
          'придумать.',
      age: 'вчера',
    ),
  ];

  static const widgetCaption = 'Визитка';
  static const widgetStatus = 'Открыт к новым идеям';

  static const appProfile = 'Обо мне';
  static const appCases = 'Кейсы';
  static const appExperience = 'Опыт';
  static const appSkills = 'Навыки';
  static const appContacts = 'Связь';
  static const appMail = 'Почта';
  static const appGithub = 'GitHub';
  static const appShotscope = 'ShotSCOPE';
  static const appTeam = 'NotDoneByOne';
  static const homeIndicatorLabel = 'На рабочий стол';
  static const back = 'Назад';

  static const strengths = <Strength>[
    Strength(
      title: 'Собираю команду с нуля',
      text:
          'Нахожу людей и распределяю роли: мобильная разработка, бэкенд, QA, '
          'аналитика. Строю структуру с руководителями направлений и '
          'регулярный ритм работы.',
    ),
    Strength(
      title: 'Работаю в неопределённости',
      text:
          'Превращаю размытую идею в требования, архитектуру и план версий. '
          'Закладываю гибкость туда, где правила будут меняться.',
    ),
    Strength(
      title: 'Выстраиваю процессы',
      text:
          'Повторяющуюся работу превращаю в понятный процесс: критерии '
          'приёмки до кода, независимая проверка, решения по метрикам.',
    ),
    Strength(
      title: 'Отвечаю за результат целиком',
      text:
          'Беру проект на себя: от разбора ТЗ и оценки до сборки для QA и '
          'релиза. Нахожу пробелы в требованиях до того, как они станут '
          'багами.',
    ),
  ];

  static const cases = <CaseStudy>[
    CaseStudy(
      id: 'shotscope',
      label: 'NotDoneByOne · с 2024',
      title: 'ShotSCOPE: продукт и команда с нуля',
      role: 'CEO и Flutter-разработчик',
      task:
          'Цифровой дневник для спортсменов-стрелков: аналогов нет, '
          'требований нет, команды нет.',
      done:
          'Собрал команду с руководителями Flutter- и бэкенд-направлений, QA '
          'и аналитиком. Поставил процессы и собственную инфраструктуру: '
          'трекер, вики, Git, почту, CI.',
      result: 'Мобильное и десктопное приложения, бэкенд, релизы в RuStore.',
      links: [
        Link(label: 'shotscope.ru', url: 'https://shotscope.ru'),
        Link(label: 'notdonebyone.ru', url: 'https://notdonebyone.ru'),
      ],
    ),
    CaseStudy(
      id: 'process',
      label: 'Процессы',
      title: 'Разработка с ИИ-агентами без потери качества',
      role: 'Автор процесса',
      task:
          'ИИ ускоряет написание кода, но без контроля качество проседает, '
          'а результат трудно проверить.',
      done:
          'Выстроил процесс, где роли распределены: критерии приёмки '
          'собираются из ТЗ до кода, реализацию проверяет независимый '
          'ревьюер, решения калибруются по метрикам.',
      result:
          'Скорость выросла, а возвратов из тестирования стало заметно '
          'меньше. Поделился подходом с коллегами.',
    ),
    CaseStudy(
      id: 'migration',
      label: 'Коммерческая разработка',
      title: 'Миграция крупного проекта на новый Flutter',
      role: 'Оценка и планирование',
      task:
          'Корпоративное приложение долго жило на старой версии Flutter. '
          'Переход затрагивает каждую фичу, а релизы останавливать нельзя.',
      done:
          'Разобрал проект по фичам, нашёл подводные камни, оценил объём и '
          'составил план перехода параллельно с релизами.',
      result: 'План на три недели с понятными рисками для команды и заказчика.',
    ),
  ];

  static const experience = <Job>[
    Job(
      period: '2026 — сейчас',
      company: 'Surf',
      position: 'Flutter-разработчик',
      text: 'Корпоративные мобильные приложения для ритейла и логистики.',
    ),
    Job(
      period: '2024 — сейчас',
      company: 'NotDoneByOne',
      position: 'Основатель, CEO',
      text:
          'Продуктовая команда. Отвечаю за продукт, людей и мобильную '
          'разработку.',
    ),
    Job(
      period: 'Образование',
      company: 'Воронежский государственный университет',
      position: 'ПММ, прикладная информатика',
      text:
          'Магистерская работа — ИИ-ассистент для разбора тренировок '
          'спортсменов.',
    ),
  ];

  static const skills = <SkillGroup>[
    SkillGroup(
      title: 'Мобильная разработка',
      items: [
        'Flutter, Dart 3',
        'Elementary, BLoC, RxDart',
        'Drift, Dio, freezed',
        'auto_route, go_router',
        'Widget- и golden-тесты',
      ],
    ),
    SkillGroup(
      title: 'Инженерные практики',
      items: [
        'CI/CD: GitHub Actions, GitLab CI',
        'Статический анализ и ревью',
        'Аналитика и мониторинг крашей',
        'ИИ-агенты в разработке',
        'Self-hosted инфраструктура',
      ],
    ),
    SkillGroup(
      title: 'Лидерство',
      items: [
        'Сборка команды и ролей',
        'Планирование версий и оценка',
        'Работа с ТЗ и аналитиками',
        'Процессы в Jira',
        'Доклады и менторство',
      ],
    ),
  ];

  static const contacts = <Link>[
    Link(
      label: 'notdonebyone@internet.ru',
      url: 'mailto:notdonebyone@internet.ru',
      caption: 'Почта',
      copyValue: 'notdonebyone@internet.ru',
    ),
    Link(
      label: 'github.com/n3xxxt',
      url: 'https://github.com/n3xxxt',
      caption: 'GitHub',
    ),
    Link(
      label: 'notdonebyone.ru',
      url: 'https://notdonebyone.ru',
      caption: 'Команда',
    ),
  ];
}

/// Уведомление на экране блокировки.
class PhoneNotification {
  const PhoneNotification({
    required this.app,
    required this.title,
    required this.text,
    required this.age,
  });

  final String app;
  final String title;
  final String text;
  final String age;
}

/// Сильная сторона из блока «Что я привношу».
class Strength {
  const Strength({required this.title, required this.text});

  final String title;
  final String text;
}

/// Кейс: задача, что сделано, результат.
class CaseStudy {
  const CaseStudy({
    required this.id,
    required this.label,
    required this.title,
    required this.role,
    required this.task,
    required this.done,
    required this.result,
    this.links = const [],
  });

  final String id;
  final String label;
  final String title;
  final String role;
  final String task;
  final String done;
  final String result;
  final List<Link> links;
}

/// Место работы или учёбы.
class Job {
  const Job({
    required this.period,
    required this.company,
    required this.position,
    required this.text,
  });

  final String period;
  final String company;
  final String position;
  final String text;
}

/// Группа компетенций.
class SkillGroup {
  const SkillGroup({required this.title, required this.items});

  final String title;
  final List<String> items;
}

/// Ссылка или контакт.
class Link {
  const Link({
    required this.label,
    required this.url,
    this.caption,
    this.copyValue,
  });

  final String label;
  final String url;
  final String? caption;
  final String? copyValue;
}
