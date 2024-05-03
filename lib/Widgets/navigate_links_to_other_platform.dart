
import 'package:url_launcher/url_launcher.dart';
//for sending user to Other platform for information or contact
whatsAppLaunchUrl() {
  const link =
      'whatsapp://send?phone=+923130339546&text=I want to know about RK LEARNING';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

instagramLaunchUrl() {
  const link = 'https://www.instagram.com/ig_rabiaaa?igsh=d2k5Ymt6cW80dm9j';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

youTubeLaunchUrl() {
  const link = 'https://youtube.com/@RKLEARNING?si=LjH23K2N91iQLuFz';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

facebookLaunchUrl() {
  const link = 'https://www.facebook.com/moazzam.samoo?mibextid=ZbWKwL';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}
