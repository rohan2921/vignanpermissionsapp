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
  var isInit=true;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value)async{
          if(isInit){
           print("1");
           var user= await FirebaseAuth.instance.currentUser();
          var data= await Firestore.instance.collection('user').document(user.uid).get();
          isTeacher=data.data['isTeacher'];
          print(isTeacher);
          setState(() {
            isInit=false;
          });
          
      }
    });
      
    super.initState();
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
      
      body: isInit? Center(child:CircularProgressIndicator()):Padding(
        padding: const EdgeInsets.all(20.0),
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: StreamBuilder(
                      stream: Firestore.instance.collection('reports').snapshots(),
                      builder: (ctx, snapshots)  {
                        
                        if (snapshots.connectionState==ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                         
                          final report = snapshots.data.documents;
                          print(isTeacher);
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
      drawer:  MainDrawer(isTeacher),
    );
  }
}
