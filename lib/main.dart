import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vignanpermissions/screens/permission_Screen.dart';
import 'package:vignanpermissions/widgets/chat/grant_premission.dart';

import './widgets/chat/new_permission.dart';
import './screens/discussions_screen.dart';
import './screens/report_details_screen.dart';

import './screens/add_report_screen.dart';
import './screens/auth_screen.dart';

import './screens/Events_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromARGB(0xFF, 0x49, 0x48, 0x9D),
          accentColor: Color.fromARGB(
              0xFF, 0x6C, 0x68, 0xF5), //#84A5C60 xFF, 0xA7, 0xCE, 0xCB 6C68F5
          accentColorBrightness: Brightness.dark,
          backgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.white,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)))),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, snapShot) {
            //if(snapShot.connectionState==ConnectionState.waiting){
            //  return SplashScreen();
            // }
            if (snapShot.hasData) {
              return EventScreen();
            } else {
              return AuthScreen();
            }
          }),
          
          
          routes: {
            EventScreen.routeName:(ctx)=>EventScreen(),
            AddReportScreen.routeName:(ctx)=>AddReportScreen(),
            ReportDetailScreen.routeName:(ctx)=> ReportDetailScreen(),
            DiscussionsScreen.routeName:(ctx)=>DiscussionsScreen(),
            NewPermission.routeName:(ctx)=>NewPermission(),
            PermissionScreen.routeName:(ctx)=>PermissionScreen(),
            GrantPermission.routeName:(ctx)=>GrantPermission()
          },
    );
  }
}
