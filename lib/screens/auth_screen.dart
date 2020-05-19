import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/auth/auth_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var _collectionFetch='user';
  void _submittedForm(String em, String un,File img, String pwd, bool login,bool isTeacher,
      BuildContext context) async {
    AuthResult response;
    if(isTeacher) _collectionFetch='teachers';
    setState(() {
      _isLoading = true;
    });
    try {
      if (login) {
        response =
            await _auth.signInWithEmailAndPassword(email: em, password: pwd);
      } else {
        response = await _auth.createUserWithEmailAndPassword(
            email: em, password: pwd);
          final ref=  FirebaseStorage.instance.ref().child('user_images').child(response.user.uid + '.jpg');
          await ref.putFile(img).onComplete;
        final url=  await ref.getDownloadURL();
        await Firestore.instance
            .collection(_collectionFetch)
            .document(response.user.uid)
            .setData({'username': un, 'email': em,'imageUrl':url});
      }
    } on PlatformException catch (err) {
      var message = 'an error occured please check you credentials';
      print(err);
      if (err != null) {
        message = err.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
    setState(() {
      _isLoading = false;
    });
   // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.white),
                    height: 120,
                    width: 120,
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/a/ae/Vignan_logo.png',
                      fit: BoxFit.cover,
                    )),
                AuthWidget(onsubmit: _submittedForm, isLoading: _isLoading),
              ],
            ),
          ),
        ));
  }
}
