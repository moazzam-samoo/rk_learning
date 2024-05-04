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
  const link =
      'https://www.instagram.com/rk_learning?igsh=MWJiMDM3OGEwbGc4Ng==';
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
  const link = 'https://www.facebook.com/RklearningOfficial?mibextid=ZbWKwL';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}
