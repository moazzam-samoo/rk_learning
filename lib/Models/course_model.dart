import 'package:cloud_firestore/cloud_firestore.dart';

class NewCourseModel {
  final String? subtitle;
  final String? price;
  final String? image;
  final String? title;
  final String? id;
  final List? playlist;
  final List? mcq;
  final List? notes;
  final Timestamp? createdAt;

  NewCourseModel(
      {this.playlist,
      this.createdAt,
      this.mcq,
      this.subtitle,
      this.price,
      this.image,
      this.id,
      this.notes,
      this.title});

  factory NewCourseModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NewCourseModel(
        id: snapshot['id'],
        title: snapshot['title'],
        subtitle: snapshot['subtitle'],
        price: snapshot['price'],
        image: snapshot['image'],
        playlist: snapshot['playlist'],
        notes: snapshot['notes'],
        createdAt: snapshot['createdAt'],
        mcq: snapshot['mcq']);
  }

  Map<String, dynamic> toDocument() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'price': price,
        'image': image,
        'playlist': playlist,
        'mcq': mcq,
        'createdAt': createdAt,
        'notes': notes
      };
}
