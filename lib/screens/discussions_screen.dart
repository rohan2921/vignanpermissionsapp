

import 'package:flutter/material.dart';

import 'package:vignanpermissions/widgets/chat/messages.dart';
import 'package:vignanpermissions/widgets/chat/new_message.dart';

class DiscussionsScreen extends StatefulWidget {
    static const routeName='/discussions-screen';
 
  @override
  _DiscussionsScreenState createState() => _DiscussionsScreenState();
}

class _DiscussionsScreenState extends State<DiscussionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussions'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[Expanded(child: Messages()), NewMessage()],
        ),
      ),
    );
  }
}
