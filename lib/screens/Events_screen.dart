import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/report_item.dart';
import '../widgets/main_drawer.dart';

class EventScreen extends StatefulWidget {
  static const routeName = '/event-screen';

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'VIGNAN',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          DropdownButton(
              underline: Container(),
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                      child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10),
                      Text('Logout')
                    ],
                  )),
                  value: 'logout',
                )
              ],
              onChanged: (item) {
                if (item == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: StreamBuilder(
                    stream:
                        Firestore.instance.collection('reports').snapshots(),
                    builder: (ctx, snapshots) {
                      if (snapshots.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        final report = snapshots.data.documents;
                        return ListView.builder(
                         // padding: EdgeInsets.all(10),
                          itemBuilder: (ctx, ind) {
                            return ReportItem(
                                report[ind]['title'], report[ind]['imageUrl']);
                          },
                          itemCount: report.length,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
