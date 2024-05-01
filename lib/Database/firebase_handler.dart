import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/course_model.dart';

class CommunityHandler {
  //Read Community
  static Stream<List<CommunityModel>> getCommunity() {
    final communityCollection =
        FirebaseFirestore.instance.collection("community");
    return communityCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => CommunityModel.fromSnapshot(e)).toList());
  }
}
