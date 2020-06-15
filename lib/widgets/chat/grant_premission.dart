import 'package:flutter/material.dart';



class GrantPermission extends StatefulWidget {
  static const routeName='/grant-permission';
  
  
  @override
  _GrantPermissionState createState() => _GrantPermissionState();
}

class _GrantPermissionState extends State<GrantPermission> {
  
  
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
            Row( 
            mainAxisAlignment : MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width:30), 
                RaisedButton(
                  color: Colors.green,
                  child: Text(
                    "Accept",
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.white, 
                    ),
                  ),
                  onPressed: (){}),
               RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Reject",
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.white, 
                    ),
                  ),
                  onPressed: (){}),
                SizedBox(width:50),
              ],
            ),
          ],
        ),
        
      ),
      ),
    );
  }
}