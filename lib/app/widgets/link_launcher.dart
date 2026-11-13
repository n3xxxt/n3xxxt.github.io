import 'package:url_launcher/url_launcher.dart';

/// Открывает ссылку в новой вкладке браузера.
Future<void> openLink(String url) =>
    launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
