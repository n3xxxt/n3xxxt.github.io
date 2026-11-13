import 'package:web/web.dart' as web;

/// Показывает, нарисована ли вокруг приложения рамка телефона.
bool isFramed() => web.document.body?.classList.contains('framed') ?? false;
