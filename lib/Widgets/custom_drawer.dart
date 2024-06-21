import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info/package_info.dart';
import 'package:rk_learning/Constants/colors.dart';
import 'package:rk_learning/Screens/Authentication%20Screen/auth/authentication_screen.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/Authentication Screen/google_auth.dart';

//<All Done --Developer Information and --Owner Information>

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String version = '';
  @override
  void initState() {
    super.initState();
    _fetchAppVersion();
  }

  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: containerColor,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 70.w, right: 70.w, bottom: 60.h, top: 24.h),
              child:
                  Lottie.asset("assets/animations/logo_rk.json", repeat: false),
            ),
            buildButton(
                context, FontAwesomeIcons.arrowRightFromBracket, "Sign Out",
                () {
              Authentication.signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AuthenticationScreen()));
            }),
            buildButton(context, FontAwesomeIcons.dev, "Developer Info", () {
              _showBottomSheetDev(context);
            }),
            buildButton(context, FontAwesomeIcons.user, "Owner Info", () {
              _showBottomSheetOwn(context);
            }),
            const Spacer(), // Pushes the following content to the bottom
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Version $version',
                  style: const TextStyle(
                    fontSize: 16,
                    color: primaryTextColor,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  buildButton(
      BuildContext context, IconData icon, String label, Function() onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryTextColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(label,
                  style: TextStyle(
                      fontSize: 17.sp,
                      color: primaryTextColor,
                      fontWeight: FontWeight.w400)),
            ],
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: primaryTextColor,
              )),
        ],
      ),
    );
  }

  _showBottomSheetDev(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: shadowColor,
        context: context,
        builder: (context) {
          return ListView(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 15),
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Colors.blue[800],
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/icons/dev.jpg",
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        reuseText("Moazzam Samoo", 16, FontWeight.bold,
                            primaryTextColor),
                        reuseText("Student of CS University of Sindh", 12,
                            FontWeight.w400, primaryTextColor)
                      ],
                    )
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: primaryTextColor,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'We Value Your Feedback\n\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'For any queries or suggestions for improvement in our app, please leave us an email at ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'Moazzamsamoo819@gmail.com',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '. Your input is highly appreciated and will help us enhance your experience.\n\n'
                                  'Thank you for helping us make our app better!',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      reuseText("Contact Information", 16, FontWeight.w700,
                          primaryTextColor),
                      SizedBox(
                        height: 10.h,
                      ),
                      _rowText("Email: ", "Moazzamsamo819@gmail.com"),
                      const Divider(),
                      reuseText("Social Accounts", 16, FontWeight.w700,
                          primaryTextColor),
                      SizedBox(
                        height: 10.h,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: primaryTextColor,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text:
                                  'Stay updated and reach out to us through our social media accounts. Follow us for the latest news, updates, and support:\n\n',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: 'Facebook:  ',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'facebook.com/Moazzam Samoo\n',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.facebook.com/share/9iuSWmYkuLWq83wC/?mibextid=qi2Omg');
                                },
                            ),
                            TextSpan(
                              text: 'LinkedIn:  ',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'linkedin.com/in/moazzam-samoo\n',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.linkedin.com/in/moazzam-samoo-a3b988248?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app');
                                },
                            ),
                            TextSpan(
                              text: 'Instagram:  ',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'instagram.com/moazzam-samoo\n',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchURL(
                                      'https://www.instagram.com/moazzam_samooo?igsh=aHZtcDZjYXk4Y2Rz');
                                },
                            ),
                          ],
                        ),
                    )
                    ],
                  ),
                ),
              ],
            ),
          ]);
        });
  }

  _showBottomSheetOwn(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: shadowColor,
        context: context,
        builder: (context) {
          return ListView(children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 15),
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Colors.blue[800],
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/icons/own.jpg"),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        reuseText("RRK", 16, FontWeight.bold, primaryTextColor),
                        reuseText("CEO and Founder", 12, FontWeight.w400,
                            primaryTextColor),
                        reuseText("RK Learning", 12, FontWeight.w400,
                            primaryTextColor)
                      ],
                    )
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: primaryTextColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Greetings,\n\n',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text:
                                  'I extend a warm welcome to RK Learning, an esteemed educational institution where excellence meets innovation. As the Chief Executive Officer and Owner, I am privileged to lead this esteemed academy, which was established on July 13, 2020, with a resolute vision to deliver unparalleled educational opportunities nationwide.\n\n',
                            ),
                            const TextSpan(
                              text:
                                  'My enduring commitment to education stems from a profound passion for teaching and an unwavering dedication to democratizing access to premium education for all. At RK Learning, our core mission is to empower learners through a harmonious blend of traditional pedagogy and cutting-edge educational technologies.\n\n',
                            ),
                            const TextSpan(
                              text:
                                  'Since our inception, RK Learning has achieved significant milestones:\n',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text:
                                  '\n- Pioneering Programs: We pride ourselves on pioneering innovative educational programs meticulously crafted to cater to the diverse needs of learners across the nation.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- National Footprint: We are steadfast in our commitment to ensuring that students from every corner of the country have equitable access to exceptional education.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- Community Integration: Through robust partnerships with coaching institutes, communities, and organizations, we actively augment educational prospects for students nationwide.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- Digital Proficiency: We have spearheaded the adoption of advanced online learning platforms to facilitate remote education and offer flexible learning avenues.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- Educator Empowerment: Our comprehensive professional development initiatives empower educators to refine their teaching methodologies and skills.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- Celebrating Student Success: We take immense pride in spotlighting the remarkable achievements of our students, many of whom have soared academically and professionally under our tutelage.\n',
                            ),
                            const TextSpan(
                              text:
                                  '\n- Accolades and Accreditation: RK Learning\'s pioneering educational approach has garnered accreditation from esteemed educational bodies and earned recognition for its innovative ethos.\n\n',
                            ),
                            const TextSpan(
                              text:
                                  'I am steadfast in my resolve to foster a nurturing and inclusive learning milieu where every student can flourish. Our ethos revolves around perpetual refinement and collaborative synergy, ensuring that RK Learning remains at the vanguard of delivering superior education.\n\n',
                            ),
                            const TextSpan(
                              text:
                                  'Thank you for considering RK Learning. Together, let us unlock the latent potential within every learner and redefine the landscape of education nationwide.\n\n',
                            ),
                            const TextSpan(
                              text: 'With warm regards,\n\n',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            const TextSpan(
                              text: 'RRK\n',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(
                              text:
                                  'Chief Executive Officer and Owner, RK Learning\n',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]);
        });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _rowText(String title, String subtitle) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: primaryTextColor,
            ),
          ),
          TextSpan(
            text: subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
