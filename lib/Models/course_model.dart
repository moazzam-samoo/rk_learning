import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityModel {
  final Timestamp? time;
  final String? text;
  final String? title;
  final String? id;

  CommunityModel({this.id, this.time, this.text, this.title});

  factory CommunityModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return CommunityModel(
      id: snapshot['id'],
      title: snapshot['title'],
      time: snapshot['time'],
      text: snapshot['text'],
    );
  }

  Map<String, dynamic> toDocument() => {
        'time': time,
        'text': text,
        'title': title,
        'id': id,
      };
}
