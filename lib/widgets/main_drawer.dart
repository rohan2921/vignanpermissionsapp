import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vignanpermissions/screens/upcoming_screen.dart';
import '../screens/permission_Screen.dart';
import '../widgets/chat/new_permission.dart';

import '../screens/discussions_screen.dart';
import '../screens/Events_screen.dart';
import '../screens/add_report_screen.dart';


class MainDrawer extends StatefulWidget {
 
    final isInit;
    final Function setInit;
    var isTeacher;
    MainDrawer(this.isInit,this.setInit,this.isTeacher);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
    
   
     
     @override
   
  void initState() {
    if(widget.isInit){
      
    Future.delayed(Duration.zero).then((value)async{ 
           var user= await FirebaseAuth.instance.currentUser();
          var data= await Firestore.instance.collection('user').document(user.uid).get();
          widget.isTeacher=data.data['isTeacher'];
            widget.setInit(widget.isTeacher);
    });
    }
    super.initState();
  
 }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Card(
          elevation: 5,
          child: ListTile(
            leading: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Vignan_logo.png/903px-Vignan_logo.png',
              height: 50,
              width: 50,
            ),
            title: Text('Home'),
            onTap: () =>
                Navigator.of(context).popAndPushNamed(EventScreen.routeName),
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Report'),
            onTap: (){
              Navigator.of(context).popAndPushNamed(AddReportScreen.routeName);
            },
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.note_add),
            title: Text(widget.isTeacher? 'Give Permission':'Ask Permissions'),
            onTap: ()async{
              try{

                
              if(widget.isTeacher){
                    Navigator.of(context).popAndPushNamed(PermissionScreen.routeName);
              }else{
                
                  Navigator.of(context).popAndPushNamed(NewPermission.routeName);
              }

              }catch(err){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something went wrong...')));
              }
              
            },
          ),
        ),
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.update),
            title:Text('Upcoming Events'),
            onTap:(){
                Navigator.of(context).popAndPushNamed(UpcomingScreen.routeName);
            }
          ),

        ),
        Card(
          elevation: 5,
          child: ListTile(
            leading: Icon(Icons.chat_bubble),
            title: Text('Discussions'),
            onTap: (){
              Navigator.of(context).popAndPushNamed(DiscussionsScreen.routeName);
            },
          ),
        ),
      ],
    ));
  }
}
