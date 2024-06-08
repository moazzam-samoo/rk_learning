import 'package:flutter/material.dart';

import '../../../Widgets/player.dart';

class Playlist extends StatelessWidget {
  final List lesson;
  final String price;
  final String name;
  final String id;

  Playlist(
      {required Key key,
      required this.lesson,
      required this.price,
      required this.id,
      required this.name})
      : super(key: key);

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
              Icons.play_arrow,
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

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: SizedBox(
          height: height * 0.48,
          width: width,
          child: ListView.builder(
              itemCount: lesson.length,
              itemBuilder: (context, index) {
                return buildCard(index, context);
              })),
    );
  }

  InkWell buildCard(int index, context) {
    var data = lesson[index];
    double height = (MediaQuery.of(context).size.height);

    return InkWell(onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Player(
          link: data['link'],
        ),
      ));
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
