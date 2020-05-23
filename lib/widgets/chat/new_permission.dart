import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPermission extends StatefulWidget {
  static const routeName='/new-message';

  @override
  _NewPermissionState createState() => _NewPermissionState();
}

class _NewPermissionState extends State<NewPermission> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _controller = new TextEditingController();

  void _askPermission() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final name =
        await Firestore.instance.collection('user').document(user.uid).get();
    Firestore.instance.collection('permissions').add({
      'topic':'about google',
      'host':'sundar pichai',
      'duration':'2-3',
      'time':10,
      'date':'12-13-20',
      'createdAt': Timestamp.now(),
      'username': name.data['username'],
      'userId': user.uid,
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Padding(
      padding: const EdgeInsets.all(20),
      child:RaisedButton(
        child:Text('Click'),
        onPressed: _askPermission,
    )));
  }
}
