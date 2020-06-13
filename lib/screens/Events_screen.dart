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

  var isTeacher=false;
  void getStatus()async{
    print("1");
    var user= await FirebaseAuth.instance.currentUser();
    var data= await Firestore.instance.collection('user').document(user.uid).get();
    isTeacher=data.data['isTeacher'];
  }
 
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
      drawer: MainDrawer(isTeacher),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: StreamBuilder(
                      stream: Firestore.instance.collection('reports').snapshots(),
                      builder: (ctx, snapshots) {
                        
                        if (snapshots.connectionState==ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          getStatus();
                          final report = snapshots.data.documents;
                          return ListView.builder(
                            
                            itemBuilder: (ctx, ind) {
                              return ReportItem(
                                  report[ind]);
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
