import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  ReportItem(this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [ClipRRect(
                borderRadius: BorderRadius.circular(20),
                      child: Container(
                        
                height: 200,
                width:double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
             
                  
                
            ),
          ),
           Text(
                title,
                textAlign: TextAlign.center,)
          
          ]);
  }
}