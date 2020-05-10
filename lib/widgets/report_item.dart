import 'package:flutter/material.dart';
import 'package:vignanpermissions/screens/report_details_screen.dart';

class ReportItem extends StatelessWidget {
  final dynamic report;

  ReportItem(this.report);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: ()=>Navigator.of(context).pushNamed(ReportDetailScreen.routeName,arguments: report),
          child: Stack(
            children: [ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                        child: Container(
                          
                  height: 200,
                  width:double.infinity,
                  child: Image.network(
                    report['imageUrl'],
                    fit: BoxFit.cover,
                  ),   
              ),
            ),
            Positioned(
                    bottom: 5,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      width: 300,
                      color: Colors.black54,
                      child: Text(
                        report['title'],
                        style: TextStyle(fontSize: 26, color: Colors.white,),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),)),
             
            
            ]),
    );
  }
}