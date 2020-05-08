import 'dart:convert';

import 'package:flutter/material.dart';

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
            onTap: (){},
          ),
        ),
        
         Card(
           elevation: 5,
                    child: ListTile(
             leading: Icon(Icons.add),
             title: Text('Add Event'),
           ),
         ),
         Card(
           elevation: 5,
                    child: ListTile(
             leading: Icon(Icons.exit_to_app),
             title: Text('Logout'),
           ),
         )
      ],
    ));
  }
}
