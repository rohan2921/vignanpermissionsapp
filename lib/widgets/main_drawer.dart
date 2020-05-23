import 'package:flutter/material.dart';
import 'package:vignanpermissions/widgets/chat/new_permission.dart';
import '../widgets/chat/new_message.dart';
import '../screens/discussions_screen.dart';
import '../screens/Events_screen.dart';
import '../screens/add_report_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            title: Text('Ask Permissions'),
            onTap: ()async{
              try{

                var user= await FirebaseAuth.instance.currentUser();
              var data= await Firestore.instance.collection('user').document(user.uid).get();
              if(data.data['isTeacher']){

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
