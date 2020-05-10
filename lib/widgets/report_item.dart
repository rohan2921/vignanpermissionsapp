import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  ReportItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 200,
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
          bottom: 10,
          right: 5,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
           // padding: EdgeInsets.all(10),
            width: 300,
            color: Colors.black54,
            child: Text(
              title,
              style: TextStyle(fontSize: 26, color: Colors.white,),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          )),
    ]);
  }
}
