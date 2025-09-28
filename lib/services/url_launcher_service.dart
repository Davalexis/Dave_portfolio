import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
      throw 'Could not launch $url';
    }
  }
}
