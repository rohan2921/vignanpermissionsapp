import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vignanpermissions/screens/Events_screen.dart';

import '../widgets/image_picker.dart';

class AddReportScreen extends StatefulWidget {
  static const routeName = '/add-report-screen';
  @override
  _AddReportScreenState createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  File _image;
  String _title;
  String _description;
  DateTime _selectedDate;
  String _guests;
  String _speakers;
  var submitted=false;
  void _setImage(File img) {
    setState(() {
      _image = img;
    });
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((d) {
      if (d == null) {
        return;
      }

      setState(() {
        _selectedDate = d;
      });
    });
  }

  Future<void> _onSubmit() async {
    var valid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_image == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No Image added'),
      ));
      return;
    }
    if (valid) {
      setState(() {
        submitted=true;
      });
      
      _formKey.currentState.save();
      try {
        final user = await _auth.currentUser();
        final ref = FirebaseStorage.instance
            .ref()
            .child('report_images')
            .child(user.uid + DateTime.now().toString() + '.jpg');
        await ref.putFile(_image).onComplete;
        final url = await ref.getDownloadURL();
        
        await Firestore.instance.collection('reports').document().setData({
          'title': _title,
          'imageUrl': url,
          'speakers': _speakers,
          'description': _description,
          'date': _selectedDate.toIso8601String(),
          'guests': _guests,
          'userId': user.uid,
        });
      } catch (err) {
        setState(() {
        submitted=true;
      });
      
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(err),
        ));
      }
      Navigator.of(context).popAndPushNamed(EventScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a report')),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 200,
                  child: _image == null
                      ? Image.network(
                          'https://djnw5a0wszky0.cloudfront.net/inkfactorywp/wp-content/uploads/2019/06/HomepageIntroAnimation2019.gif')
                      : Image.file(_image,
                          fit: BoxFit.cover, width: double.infinity),
                ),
              ),
              UserImagePicker(_setImage,false),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title',labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  _title = val;
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a valid title';
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Guests'),
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  _guests = val;
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter guest-name or None';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Speakers'),
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  _speakers = val;
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter speake/s name/s';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (val) {
                  _description = val;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 10)
                    return 'Minimum of ten characters required';
                  return null;
                },
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text(
                  'Choose Date',
                ),
                trailing: _selectedDate == null
                    ? Text('')
                    : Text(DateFormat.yMd().format(_selectedDate)),
                onTap: _presentDatePicker,
              ),
              FlatButton(onPressed: submitted? null:
                  _onSubmit
              ,child: Text('Submit')),
            ],
          ),
        ),
      )),
    );
  }
}
