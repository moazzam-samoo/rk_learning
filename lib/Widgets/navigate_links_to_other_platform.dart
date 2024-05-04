import 'package:url_launcher/url_launcher.dart';

///These are the platform Switches that move user to new platform.
///for the contact or information.

//Move user to whatsApp Account and send message as well.
whatsAppLaunchUrl() {
  const link =
      'whatsapp://send?phone=+923130339546&text=I want to know about RK LEARNING';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

//Move user to Instagram Account
instagramLaunchUrl() {
  const link =
      'https://www.instagram.com/rk_learning?igsh=MWJiMDM3OGEwbGc4Ng==';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

//Move user to YouTube Channel
youTubeLaunchUrl() {
  const link = 'https://youtube.com/@RKLEARNING?si=LjH23K2N91iQLuFz';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}

//Move user to Facebook Account
facebookLaunchUrl() {
  const link = 'https://www.facebook.com/RklearningOfficial?mibextid=ZbWKwL';
  launchUrl(
    Uri.parse(link),
    mode: LaunchMode.platformDefault,
  );
}
