import 'package:flutter/material.dart';
import '../models/Report.dart';
import '../widgets/report_item.dart';
import '../widgets/main_drawer.dart';

class EventScreen extends StatelessWidget {
  List<Report> loadedReports = [
    Report('Machine Learning workshop', 'This is ML work shop',
        'https://images.unsplash.com/photo-1523580494863-6f3031224c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80'),
    Report('Artificial Intelligence workshop', 'This is Ai work shop',
        'https://images.pexels.com/photos/1709003/pexels-photo-1709003.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
    Report('Flutter workshop', 'This is Flutter work shop',
        'https://images.pexels.com/photos/3321797/pexels-photo-3321797.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
    Report('Coding workshop', 'This is Coding work shop',
        'https://images.pexels.com/photos/3321794/pexels-photo-3321794.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
    Report('Data Structures and Algorithms', 'This is dsa work shop',
        'https://images.unsplash.com/photo-1524178232363-1fb2b075b655?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'VIGNAN',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: MainDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        itemCount: loadedReports.length,
        itemBuilder: (context, i) => ReportItem(
          loadedReports[i].title,
          loadedReports[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }
}
