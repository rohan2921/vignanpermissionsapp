import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vignanpermissions/widgets/chat/grant_premission.dart';

class PermissionScreen extends StatefulWidget {
  static const routeName = '/permission-screen';
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
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
                  final perms = snaps.data.documents;
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
                              GrantPermission.routeName,
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
