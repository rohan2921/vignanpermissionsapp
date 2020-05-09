import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class UserImagePicker extends StatefulWidget {
  final Function fn;
  UserImagePicker(this.fn);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageShow;
  void _pickImage(ctx) async{
    var pickedImage;
   showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(
            onTap: () => {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton.icon(onPressed: () async{
                    pickedImage= await ImagePicker.pickImage(source: ImageSource.camera,imageQuality: 50);
                     
          _pickedImageShow=pickedImage;
        
        widget.fn(_pickedImageShow);
                    Navigator.of(context).pop(bctx);
                }, icon: Icon(Icons.camera), label: Text('Camera')),
                FlatButton.icon(onPressed: () async{
                  pickedImage= await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50,maxWidth: 150);
                   
          _pickedImageShow=pickedImage;
        
         widget.fn(_pickedImageShow);
                  Navigator.of(context).pop(bctx);
                }, icon: Icon(Icons.photo_album), label:Text('Gallery'))
              ],
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
        
  }
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(onPressed: ()=>_pickImage(context), icon: Icon(Icons.add_a_photo),label: Text('Add Image'),);
  }
}