import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReportDetailScreen extends StatelessWidget {
  static const routeName = '/report-detail-screen';

  @override
  Widget build(BuildContext context) {
    final report = ModalRoute.of(context).settings.arguments as dynamic;
    // print(report[0]);
    return Scaffold(
      appBar: AppBar(
        title: Text(report['title']),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      width: double.infinity,
                      height: 300,
                      child: Image.network(
                        report['imageUrl'],
                        fit: BoxFit.contain,
                      ))),
             
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: Text(
                    'Date : ' + (report['date']).substring(0, 10),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: Text(
                    'Guest/s : ' + report['guests'],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: Text(
                    'Speaker/s : ' + report['speakers'],
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: 300,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 22, color: Colors.black),
                      children: [
                        TextSpan(text: 'Description : ' + report['description'])
                      ],
                    ),
                    softWrap: true,
                    maxLines: 20,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
