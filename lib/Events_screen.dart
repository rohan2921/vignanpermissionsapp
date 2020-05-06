import 'package:flutter/material.dart';
import './main_drawer.dart';

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vignan',
          style: TextStyle(fontFamily: 'Raleway',
          fontWeight: FontWeight.bold
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
