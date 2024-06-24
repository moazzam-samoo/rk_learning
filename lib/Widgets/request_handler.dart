import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rk_learning/Constants/capitalize.dart';
import 'package:rk_learning/Widgets/reuseable_widgets.dart';

import '../Constants/colors.dart';
import '../Constants/responsive_screen.dart';

class RequestHandler {
  // Payment Dialogs...
  static Future<String> checkCoursePurchaseStatus(String courseId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('purchase_requests')
          .where('userId', isEqualTo: user.uid)
          .where('courseId', isEqualTo: courseId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var status = querySnapshot.docs.first['status'];
        return status;
      }
    }
    return 'not_purchased';
  }

  static void showPendingRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: containerColor,
          title: reuseText(
              "Access Request Sent", 18, FontWeight.w400, primaryTextColor),
          content: SizedBox(
            height: ResponsiveScreen.height(context) * 0.360,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reuseText(
                    'Thank you for submitting your access request for course enrollment. Our administrative team will review your request for verification. Once the verification process is complete, you will be granted access to the course.',
                    12,
                    FontWeight.normal,
                    Colors.white),
                SizedBox(
                  height: 10.h,
                ),
                reuseText(
                    'If, for any reason, your course access is not granted, please do not hesitate to contact us via WhatsApp at 03130339546 for further assistance',
                    12,
                    FontWeight.normal,
                    Colors.white),
                SizedBox(
                  height: 10.h,
                ),
                reuseText(
                    'We appreciate your patience and look forward to supporting your learning journey\nRRK\n(CEO & Founder)',
                    12,
                    FontWeight.normal,
                    Colors.white),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showPurchaseDialog(
      BuildContext context, String courseId, String courseTitle) {
    bool isRequestSent = false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: containerColor,
            title:
                reuseText("Enroll Now!", 20, FontWeight.w400, primaryTextColor),
            content: SizedBox(
              height: ResponsiveScreen.height(context) * 0.430,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reuseText(
                      'Unlock Your Future: Enroll Now and Transform Your Career!',
                      14,
                      FontWeight.normal,
                      Colors.white),
                  SizedBox(
                    height: 10.h,
                  ),
                  reuseText('Pay Now With', 16, FontWeight.w500, Colors.white),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/icons/easypaisa.png",
                        scale: 9,
                      ),
                      reuseText('Easypaisa: 0313-0339546', 14, FontWeight.w300,
                          Colors.white),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/icons/jazz.png",
                        scale: 9,
                      ),
                      reuseText('Jazz Cash: 0313-0339546', 14, FontWeight.w300,
                          Colors.white),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  reuseText('For Bank account WhatsApp us', 16, FontWeight.w400,
                      Colors.white),
                  SizedBox(height: 20.h),
                  reuseText(
                      'Dear Student, \nTo access the course, kindly complete your payment and send us the confirmation screenshot via WhatsApp.\nThank you for your cooperation💜',
                      12,
                      FontWeight.w300,
                      Colors.white),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (!isRequestSent) {
                    setState(() {
                      isRequestSent = true;
                    });
                    try {
                      sendPurchaseRequest(context, courseId, courseTitle);
                    } catch (error) {
                      setState(() {
                        isRequestSent = false;
                      });
                    }
                  }
                },
                child: const Text('Pay Now'),
              ),
            ],
          );
        });
      },
    );
  }

  static void showDeniedRequestDialog(
      BuildContext context, String courseId, String courseTitle) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: containerColor,
          title: reuseText(
              "Course Access Denied!", 18, FontWeight.w400, primaryTextColor),
          content: SizedBox(
            height: ResponsiveScreen.height(context) * 0.180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reuseText(
                    'Thank you for your enrollment request. Unfortunately, it has been denied due to a payment issue.',
                    12,
                    FontWeight.normal,
                    Colors.white),
                SizedBox(
                  height: 10.h,
                ),
                reuseText(
                    'Please verify your payment and resubmit your request. For assistance, contact us via WhatsApp at 03130339546.\nWe appreciate your understanding.',
                    12,
                    FontWeight.normal,
                    Colors.white),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the denied request dialog
                sendPurchaseRequest(context, courseId, courseTitle,
                    true); // Send the purchase request again
              },
              child: const Text('Request Again'),
            ),
          ],
        );
      },
    );
  }

  static sendPurchaseRequest(
      BuildContext context, String courseId, String courseTitle,
      [bool isRetry = false]) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (isRetry) {
        // Update existing request status to 'pending'
        var querySnapshot = await FirebaseFirestore.instance
            .collection('purchase_requests')
            .where('userId', isEqualTo: user.uid)
            .where('courseId', isEqualTo: courseId)
            .where('status', isEqualTo: 'denied')
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          var docId = querySnapshot.docs.first.id;
          await FirebaseFirestore.instance
              .collection('purchase_requests')
              .doc(docId)
              .update({
            'status': 'pending',
            'timestamp': FieldValue.serverTimestamp(),
            'docId': docId,
          });

          // Show purchase request sent dialog
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismissing manually
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Purchase Request Sent'),
                content: Text('Your purchase request is being processed.'),
              );
            },
          );

          // Close dialogs after 2 seconds
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context)
                .popUntil((route) => route.isFirst); // Dismiss all dialogs
          });

          return;
        }
      }

      // Send new purchase request
      var newDocRef =
          await FirebaseFirestore.instance.collection('purchase_requests').add({
        'userId': user.uid,
        'userName': user.displayName?.split(" ")[0].capitalize(),
        'userEmail': user.email,
        'courseId': courseId,
        'courseName': courseTitle,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Get the document ID of the newly created request
      String newDocId = newDocRef.id;

      // Update the newly created document with its ID
      await FirebaseFirestore.instance
          .collection('purchase_requests')
          .doc(newDocId)
          .update({
        'docId': newDocId,
      });

      // Show purchase request sent dialog
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dismissing manually
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: containerColor,
            title: reuseText(
                "Request Submitted", 22, FontWeight.w400, primaryTextColor),
            content: reuseText(
                'Your course access request has been successfully submitted. Thank you for your patience. If you need further assistance, please contact us via WhatsApp at 03130339546.',
                14,
                FontWeight.normal,
                primaryTextColor),
          );
        },
      );

      // Close dialogs after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        int count = 0;
        Navigator.of(context).popUntil((route) {
          return count++ == 2;
        });
      });
    }
  }
}
