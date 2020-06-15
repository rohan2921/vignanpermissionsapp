
import 'package:flutter/material.dart';



class UpcomingEvent extends StatelessWidget {
  static const routeName='/upcoming-event';
  
  Widget build(BuildContext context) {
    final perm = ModalRoute.of(context).settings.arguments as dynamic;
   
    return Scaffold(
      appBar: AppBar(title: Text('Permissions')),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('TOPIC : ${perm['topic']}' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('HOST : ${perm['host']}' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('DATE : ${perm['date']}' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('TIME : ${perm['time']}' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('DURATION : ${perm['duration']}' , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            
          ],
        ),
        
      ),
      ),
    );
  }
}