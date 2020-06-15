import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewPermission extends StatefulWidget {
  static const routeName='/new-message';

  @override
  _NewPermissionState createState() => _NewPermissionState();
}

class _NewPermissionState extends State<NewPermission> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   String _topic;
 
  DateTime _selectedDate;
  String _hosts;
  String _speakers;
 

  List<String> _times=['9:00','10:10','10:30','12:10','1:00','2:00'];
  List<String> _durations=['1','2','3','4','5','6'];
   String _selectedDuration='1';
    String _selectedTime='9:00';

  void _askPermission() async {
     var valid = _formKey.currentState.validate();
     if(!valid) return;
     if(_selectedDate==null) return;
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final name =
        await Firestore.instance.collection('user').document(user.uid).get();
    Firestore.instance.collection('permissions').add({
      'topic':_topic,
      'host':_hosts,
      'speakers':_speakers,
      'duration':_selectedDuration,
      'time':_selectedTime,
      'date':_selectedDate,
      'createdAt': Timestamp.now(),
      'username': name.data['username'],
      'userId': user.uid,
      'read':false
    });
    
  }
   void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2021))
        .then((d) {
      if (d == null) {
        return;
      }

      setState(() {
        _selectedDate = d;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Topic',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  _topic = val;
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter Topic';
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Host'),
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                onSaved: (val) {
                  _hosts = val;
                },
                validator: (value) {
                  if (value.isEmpty) return 'Please enter Host-name';
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
                    : Text((_selectedDate).toString()),
                onTap: _presentDatePicker,
              ),
              Row( //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Start Time',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width:50),
                  DropdownButton(
                    hint: Text('Choose'),
                  value: _selectedTime,
                  items: _times.map((time) {
              return DropdownMenuItem(
                
                child: new Text(time),
                value: time,
              ); }).toList(),
                  onChanged: (newValue){
                    setState(() {
                      _selectedTime=newValue;
                    });
                  },
                ),
                
                ],
              ),
          Row( //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Duration in hours',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width:30),
                  DropdownButton(
                    hint: Text('Choose'),
                  value: _selectedDuration,
                  
                  items: _durations.map((duration) {
              return DropdownMenuItem(
                
                child: new Text(duration),
                value: duration,
              ); }).toList(),
                  onChanged: (newvalue){
                    setState(() {
                      _selectedDuration=newvalue;
                    });
                  },
                ),
                
                ],
              ),Padding(padding: EdgeInsets.all(15)),
              FlatButton(onPressed: _askPermission, color: Colors.blue,
              child: Text('Ask',style: TextStyle(fontWeight: FontWeight.bold),)),
            ],
          ),
        ),
      )),);
  }
}
