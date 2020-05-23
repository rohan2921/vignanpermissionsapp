import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ReportDetailScreen extends StatelessWidget {
  static const routeName = '/report-detail-screen';

  @override
  Widget build(BuildContext context) {
    final report = ModalRoute.of(context).settings.arguments as dynamic;
    // print(report[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        report['imageUrl'],
                        fit: BoxFit.contain,
                      ))),
              SizedBox(height: 20),
              titlecard(report['title']),
              datecard(report['Date']),
              guestcard(report['guests']),
              speakerscard(report['speakers']),
              descriptioncard(report['description']),
              // descriptioncard(),
            ],
          ),
        ),
      ),
    );
  }

   Widget titlecard(String  text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              child: Text(
                'Title    :  ' + "$text",
                textAlign: TextAlign.justify,
                style: TextStyle( 
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 Widget datecard(DateTime text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              child: Text(
                'Date     :  ' + "date here",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget guestcard(String text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              child: Text(
                'Guests  :  ' + "$text",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget speakerscard(String text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 300,
              child: Text(
                'Speaker :  ' + "$text",
               // textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget descriptioncard(String text) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
         // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 300,
              child: Text(
                'Description: ' + "$text",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
