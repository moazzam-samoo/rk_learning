import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/course_model.dart';
import '../Models/notification_model.dart';

class NotificationHandler {
  //Read Notifications
  static Stream<List<NotificationModel>> getNotifications() {
    final communityCollection =
        FirebaseFirestore.instance.collection("notifications");
    return communityCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((e) => NotificationModel.fromSnapshot(e))
        .toList());
  }

  //Read Course
  static Stream<List<NewCourseModel>> readCourse() {
    final courseCollection = FirebaseFirestore.instance.collection("course");
    return courseCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => NewCourseModel.fromSnapshot(e)).toList());
  }
}
