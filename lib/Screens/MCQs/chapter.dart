import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'mcq.dart';

class Chapter extends StatelessWidget {
  final List chapter;
  int isBuy;
  final String price;
  final String id;
  final String name;
  bool isHome;
  Chapter(
      {super.key,
      this.isHome = false,
      required this.chapter,
      required this.isBuy,
      required this.price,
      required this.id,
      required this.name});

  int index = 1;

  SizedBox buildPlayButton(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: Card(
          margin: EdgeInsets.all(0),
          elevation: 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.book,
              color: Colors.white,
              size: 31,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height);
    double width = (MediaQuery.of(context).size.width);

    if (isBuy == 3) {
      return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.get('course');

              if (data != null) {
                for (var course in data) {
                  if (id == course['id']) {
                    if (course['isBuy']) {
                      isBuy = 2;
                    } else {
                      isBuy = 1;
                    }
                    break;
                  }
                }
              }
              return buildFutureBody(height, width);
            }
            return const Center(
                child: SizedBox(
                    width: 60, height: 60, child: CircularProgressIndicator()));
          });
    }

    return buildBody(height, width);
  }

  Widget buildFutureBody(double height, double width) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("MCQ"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: SizedBox(
            height: isHome ? double.maxFinite : height * 0.48,
            width: width,
            child: ListView.builder(
                itemCount: chapter.length,
                itemBuilder: (context, index) {
                  return buildCard(index, context);
                })),
      ),
    );
  }

  Padding buildBody(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: SizedBox(
          height: isHome ? double.maxFinite : height * 0.48,
          width: width,
          child: ListView.builder(
              itemCount: chapter.length,
              itemBuilder: (context, index) {
                return buildCard(index, context);
              })),
    );
  }

  InkWell buildCard(int index, context) {
    var data = chapter[index];
    double height = (MediaQuery.of(context).size.height);
    return InkWell(onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => MCQ(mcq: chapter[index]['questions']))));
      child:
      Container(
        height: height * 0.11,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                spreadRadius: 0.5,
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: buildPlayButton(context),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              data['title'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      );
    });
  }
}
