import 'package:url_launcher/url_launcher.dart';

abstract class UrlHelper {
  static Future<bool> openUrl(String value) async {
    try {
      final uri = Uri.base.resolve(value);
      if (!['https', 'http', 'mailto'].contains(uri.scheme)) return false;
      return await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_blank',
      );
    } catch (_) {
      return false;
    }
  }

  static Future<bool> sendEmail(
    String email, {
    String? subject,
    String? body,
  }) => openUrl(
    Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': ?subject,
        'body': ?body,
      },
    ).toString(),
  );
}
