import 'package:url_launcher/url_launcher.dart';

abstract class UrlHelper {
  static Future<bool> openUrl(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> sendEmail(String email, {String? subject, String? body}) async {
    try {
      final Map<String, String> queryParams = {};
      if (subject != null) queryParams['subject'] = subject;
      if (body != null) queryParams['body'] = body;

      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      return await launchUrl(emailLaunchUri);
    } catch (_) {
      return false;
    }
  }
}
