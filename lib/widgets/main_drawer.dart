import 'package:flutter/material.dart';
import 'package:vignanpermissions/widgets/chat/new_permission.dart';

import '../screens/discussions_screen.dart';
import '../screens/Events_screen.dart';
import '../screens/add_report_screen.dart';


class MainDrawer extends StatelessWidget {
  final  isTeacher;
  MainDrawer(this.isTeacher);
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
            title: Text(isTeacher? 'Give Permission':'Ask Permissions'),
            onTap: ()async{
              try{

                
              if(isTeacher){

              }else{
                print(isTeacher);
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
