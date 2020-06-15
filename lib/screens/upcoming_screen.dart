import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:vignanpermissions/widgets/upcoming_event.dart';

class UpcomingScreen extends StatefulWidget {
  static const routeName = '/upcoming-screen';

  @override
  _UpcomingScreenState createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Permissions")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream:
                    Firestore.instance.collection('permissions').snapshots(),
                builder: (ctx, snaps) {
                  if (snaps.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final data = snaps.data.documents;
                  List<DocumentSnapshot> perms=[];
                  for(int i=0;i<data.length;i++){
                        if(data[i]['accepted']){
                          perms.add(data[i]);
                        }
                  }
                  return ListView.builder(
                    itemBuilder: (ctx, ind) {
                      return Card(
                        elevation: 10,
                                              child: ListTile(
                          leading: Text(
                            perms[ind]['topic'],
                            style: TextStyle(
                                color: perms[ind]['read']
                                    ? Colors.blue[300]
                                    : Colors.red[400],
                                    fontSize: 22  ,
                                    ),
                                
                          ),
                          onTap: () => Navigator.of(context).pushNamed(
                              UpcomingEvent.routeName,
                              arguments: perms[ind]),
                        ),
                      );
                    },
                    itemCount: perms.length,
                    );
                }),
          ),
        ],
      ),
    );
  }
}
