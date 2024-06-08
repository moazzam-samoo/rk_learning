import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final Timestamp? time;
  final String? text;
  final String? title;
  final String? id;
  final String? author;
  final String? deadLine;

  NotificationModel(
      {this.id, this.deadLine, this.author, this.time, this.text, this.title});

  factory NotificationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NotificationModel(
      id: snapshot['id'],
      title: snapshot['title'],
      time: snapshot['time'],
      text: snapshot['text'],
      author: snapshot['author'],
      deadLine: snapshot['deadLine'],
    );
  }

  Map<String, dynamic> toDocument() => {
    'time': time,
    'text': text,
    'title': title,
    'deadLine': deadLine,
    'author': author,
    'id': id,
  };
}
