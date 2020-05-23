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
        title: Text(report['title']),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(height: 20),
              Card(
                              child: Container(
                  width: 300,
                  child: FittedBox(
                                    child: Text(
                      'Date : ' + report['date'],
                      textAlign: TextAlign.center,
                      
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: Text(
                  'Guest/s : ' + report['guests'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: Text(
                  'Speaker/s : ' + report['speakers'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15),
                width: 300,
                child:  RichText(
                        text: TextSpan(
                          
                          style: TextStyle(fontSize:22,color: Colors.black),
                          children: [
                            TextSpan(
                                text: 'Description : ' +
                                    report['description'])
                          ],
                        ),
                        softWrap: true,
                        maxLines: 20,
                        overflow: TextOverflow.visible,
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
