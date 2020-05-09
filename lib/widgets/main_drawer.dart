

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vignanpermissions/screens/Events_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Card(
          elevation: 5,
                  child: ListTile(
                    leading: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/a/ae/Vignan_logo.png',
              height: 50,
              width: 50,
            ),
            title: Text('Home'),
            onTap: ()=> Navigator.of(context).popAndPushNamed(EventScreen.routeName),
          ),
        ),
        
         Card(
           elevation: 5,
                    child: ListTile(
             leading: Icon(Icons.add),
             title: Text('Add Event'),
             title: Text('Add Report'),
           ),
         ),Card(
           elevation: 5,
                    child: ListTile(
            // leading: ,
             title: Text('Discussions'),
             onTap: null,

           ),
         ),
         Card(
           elevation: 5,
                    child: ListTile(

             leading: Icon(Icons.exit_to_app),
             title: Text('Logout'),

             leading: Icon(Icons.chat),
             title: Text('Discussions'),
             onTap: null,

           ),
         )
      ],
    ));
  }
}
