import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.white,
                Colors.white,
              ]),
            ),
            child: Container(
                child: Column(
              children: <Widget>[
                Material(
                  child:
                      Image.asset('assets/logo.jpg', width: 400, height: 130),
                ),
              ],
            ))),
        buildTile('Ask Permission', Icons.add, () => {}),
        buildTile('Past Events', Icons.rate_review, () => {}),
        buildTile('Logout', Icons.settings_power, () => {}),
      ],
    ));
  }
}

class buildTile extends StatelessWidget {
  String text;
  Function ontap;
  IconData icon;
  buildTile(this.text, this.icon, this.ontap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
          splashColor: Colors.lightBlueAccent[50],
          onTap: ontap,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
