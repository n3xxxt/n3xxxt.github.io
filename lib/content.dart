/// Содержимое визитки: все тексты приложения.
abstract final class Content {
  static const name = 'Андрей Никитцев';
  static const role = 'Flutter-разработчик\u00A0· основатель\u00A0NotDoneByOne';
  static const pitch =
      'Строю продукты, команды и\u00A0процессы там, где\u00A0ещё\u00A0нет\u00A0готовых\u00A0решений.';
  static const about =
      'Разрабатываю мобильные приложения в\u00A0Surf. В\u00A0своей команде NotDoneByOne '
      'прошёл путь от\u00A0идеи до\u00A0продукта в\u00A0сторе: собрал людей, процессы и\u00A0'
      'инфраструктуру\u00A0с\u00A0нуля.';
  static const location = 'Воронеж';
  static const photoUrl = 'photo.jpg';
  static const photoCardUrl = 'photo_card.jpg';
  static const photoPlaceholder = 'Место для\u00A0фото';

  static const tabProfile = 'Профиль';
  static const tabCases = 'Кейсы';
  static const tabContacts = 'Связь';

  static const sectionApproach = 'Что\u00A0я\u00A0привношу';
  static const sectionExperience = 'Опыт';
  static const sectionSkills = 'Компетенции';
  static const casesTitle = 'Что\u00A0построено';
  static const casesSubtitle =
      'Истории о\u00A0том, как\u00A0я\u00A0запускаю новое и\u00A0довожу до\u00A0рабочего\u00A0состояния.';
  static const contactsTitle = 'Давайте поговорим';
  static const contactsSubtitle =
      'Открыт к\u00A0разговору о\u00A0работе в\u00A0команде, где\u00A0нужно строить\u00A0новое.';
  static const caseTask = 'Задача';
  static const caseDone = 'Что\u00A0сделал';
  static const caseResult = 'Результат';
  static const copied = 'Скопировано';
  static const themeToggle = 'Сменить тему';

  static const unlockHint = 'Смахните вверх, чтобы\u00A0открыть';
  static const unlockHintPointer =
      'Нажмите или\u00A0смахните вверх, чтобы\u00A0открыть';
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
      title: 'Команда собрана\u00A0с\u00A0нуля',
      text:
          'Flutter, бэкенд, QA\u00A0и\u00A0аналитика\u00A0— у\u00A0каждого направления свой\u00A0'
          'руководитель.',
      age: '2\u00A0мин',
    ),
    PhoneNotification(
      app: 'ShotSCOPE',
      title: 'Релиз в\u00A0RuStore',
      text: 'Продукт прошёл путь от\u00A0идеи\u00A0до\u00A0стора.',
      age: '1\u00A0ч',
    ),
    PhoneNotification(
      app: 'Кейсы',
      title: 'Где\u00A0нет\u00A0готовых\u00A0решений',
      text:
          'Новый продукт, новая команда, процесс, который предстоит\u00A0'
          'придумать.',
      age: 'вчера',
    ),
  ];

  static const widgetCaption = 'Визитка';
  static const widgetStatus = 'Открыт к\u00A0новым\u00A0идеям';

  static const appProfile = 'Обо\u00A0мне';
  static const appCases = 'Кейсы';
  static const appExperience = 'Опыт';
  static const appSkills = 'Навыки';
  static const appContacts = 'Связь';
  static const appMail = 'Почта';
  static const appGithub = 'GitHub';
  static const appShotscope = 'ShotSCOPE';
  static const appTeam = 'NotDoneByOne';
  static const homeIndicatorLabel = 'На\u00A0рабочий стол';
  static const back = 'Назад';

  static const strengths = <Strength>[
    Strength(
      title: 'Собираю команду\u00A0с\u00A0нуля',
      text:
          'Нахожу людей и\u00A0распределяю роли: мобильная разработка, бэкенд, QA, '
          'аналитика. Строю структуру с\u00A0руководителями направлений и\u00A0'
          'регулярный ритм\u00A0работы.',
    ),
    Strength(
      title: 'Работаю в\u00A0неопределённости',
      text:
          'Превращаю размытую идею в\u00A0требования, архитектуру и\u00A0план версий. '
          'Закладываю гибкость туда, где\u00A0правила будут\u00A0меняться.',
    ),
    Strength(
      title: 'Выстраиваю процессы',
      text:
          'Повторяющуюся работу превращаю в\u00A0понятный процесс: критерии '
          'приёмки до\u00A0кода, независимая проверка, решения\u00A0по\u00A0метрикам.',
    ),
    Strength(
      title: 'Отвечаю за\u00A0результат\u00A0целиком',
      text:
          'Беру проект на\u00A0себя: от\u00A0разбора ТЗ\u00A0и\u00A0оценки до\u00A0сборки для\u00A0QA\u00A0и\u00A0'
          'релиза. Нахожу пробелы в\u00A0требованиях до\u00A0того, как\u00A0они\u00A0станут\u00A0'
          'багами.',
    ),
  ];

  static const cases = <CaseStudy>[
    CaseStudy(
      id: 'shotscope',
      label: 'NotDoneByOne\u00A0·\u00A0с\u00A02024',
      title: 'ShotSCOPE: продукт и\u00A0команда\u00A0с\u00A0нуля',
      role: 'CEO\u00A0и\u00A0Flutter-разработчик',
      task:
          'Цифровой дневник для\u00A0спортсменов-стрелков: аналогов нет, '
          'требований нет, команды\u00A0нет.',
      done:
          'Собрал команду с\u00A0руководителями Flutter- и\u00A0бэкенд-направлений, QA\u00A0'
          'и\u00A0аналитиком. Поставил процессы и\u00A0собственную инфраструктуру: '
          'трекер, вики, Git, почту,\u00A0CI.',
      result:
          'Мобильное и\u00A0десктопное приложения, бэкенд, релизы\u00A0в\u00A0RuStore.',
      links: [
        Link(label: 'shotscope.ru', url: 'https://shotscope.ru'),
        Link(label: 'notdonebyone.ru', url: 'https://notdonebyone.ru'),
      ],
    ),
    CaseStudy(
      id: 'process',
      label: 'Процессы',
      title: 'Разработка с\u00A0ИИ-агентами без\u00A0потери\u00A0качества',
      role: 'Автор процесса',
      task:
          'ИИ\u00A0ускоряет написание кода, но\u00A0без\u00A0контроля качество проседает, '
          'а\u00A0результат трудно\u00A0проверить.',
      done:
          'Выстроил процесс, где\u00A0роли распределены: критерии приёмки '
          'собираются из\u00A0ТЗ\u00A0до\u00A0кода, реализацию проверяет независимый '
          'ревьюер, решения калибруются\u00A0по\u00A0метрикам.',
      result:
          'Скорость выросла, а\u00A0возвратов из\u00A0тестирования стало заметно '
          'меньше. Поделился подходом\u00A0с\u00A0коллегами.',
    ),
    CaseStudy(
      id: 'migration',
      label: 'Коммерческая разработка',
      title: 'Миграция крупного проекта на\u00A0новый\u00A0Flutter',
      role: 'Оценка и\u00A0планирование',
      task:
          'Корпоративное приложение долго жило на\u00A0старой версии Flutter. '
          'Переход затрагивает каждую фичу, а\u00A0релизы останавливать\u00A0нельзя.',
      done:
          'Разобрал проект по\u00A0фичам, нашёл подводные камни, оценил объём и\u00A0'
          'составил план перехода параллельно\u00A0с\u00A0релизами.',
      result:
          'План на\u00A0три\u00A0недели с\u00A0понятными рисками для\u00A0команды\u00A0и\u00A0заказчика.',
    ),
  ];

  static const experience = <Job>[
    Job(
      period: '2026\u00A0— сейчас',
      company: 'Surf',
      position: 'Flutter-разработчик',
      text:
          'Корпоративные мобильные приложения для\u00A0ритейла\u00A0и\u00A0логистики.',
    ),
    Job(
      period: '2024\u00A0— сейчас',
      company: 'NotDoneByOne',
      position: 'Основатель, CEO',
      text:
          'Продуктовая команда. Отвечаю за\u00A0продукт, людей и\u00A0мобильную\u00A0'
          'разработку.',
    ),
    Job(
      period: 'Образование',
      company: 'Воронежский государственный университет',
      position: 'ПММ, прикладная информатика',
      text:
          'Магистерская работа\u00A0— ИИ-ассистент для\u00A0разбора тренировок\u00A0'
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
        'Widget- и\u00A0golden-тесты',
      ],
    ),
    SkillGroup(
      title: 'Инженерные практики',
      items: [
        'CI/CD: GitHub Actions, GitLab CI',
        'Статический анализ\u00A0и\u00A0ревью',
        'Аналитика и\u00A0мониторинг\u00A0крашей',
        'ИИ-агенты в\u00A0разработке',
        'Self-hosted инфраструктура',
      ],
    ),
    SkillGroup(
      title: 'Лидерство',
      items: [
        'Сборка команды\u00A0и\u00A0ролей',
        'Планирование версий\u00A0и\u00A0оценка',
        'Работа с\u00A0ТЗ\u00A0и\u00A0аналитиками',
        'Процессы в\u00A0Jira',
        'Доклады и\u00A0менторство',
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
