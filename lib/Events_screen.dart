import 'package:flutter/material.dart';
import './main_drawer.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'VIGNAN',
          style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
