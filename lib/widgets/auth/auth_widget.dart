import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../image_picker.dart';


class AuthWidget extends StatefulWidget {
  final Function onsubmit;
  final isLoading;
  AuthWidget({@required this.onsubmit, @required this.isLoading});
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userPassword = '';
  String _username = '';
  String teacherId = 'rohan';
  var _isTeacher = false;
  var _userImageFile;
  var _keyMatched = false;
  var _key;

  void setImage(File img) {
    setState(() {
      _userImageFile = img;
    });
  }

  void _subbmitted() {
    var valid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No Image added'),
      ));
      return;
    }
    if (_isTeacher && _keyMatched == false) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Enter valid confirmation key'),
      ));
      return;
    }
    if (valid) {
      _formKey.currentState.save();
      widget.onsubmit(_userEmail.trim(), _username.trim(), _userImageFile,
          _userPassword.trim(), _isLogin, _isTeacher, context);
    }
  }

  void _getKey(String givenKey) async {
    if (_key == null) {
      var _fetched = await Firestore.instance
          .collection('teachersAuth')
          .document('confirmation')
          .get();
      _key = _fetched.data['key'];
    }
    if (givenKey == _key) {
      _keyMatched = true;
    } else {
       Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Enter valid confirmation key'),
      ));
      setState(() {
        _isTeacher = false;
      });
      
    }
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController enteredKeyController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Enter the Key'),
            content: TextField(
              controller: enteredKeyController,
            ),
            actions: <Widget>[
              MaterialButton(
                  elevation: 5,
                  child: Text(
                    "Submit",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    _getKey(enteredKeyController.text.toString());
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (!_isLogin)
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: _userImageFile == null
                        ? AssetImage('assets/add_image.gif')
                        : FileImage(_userImageFile),
                  ),
                if (!_isLogin) UserImagePicker(setImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  onSaved: (val) {
                    _userEmail = val;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@'))
                      return 'Please enter a valid email';
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 5)
                        return 'Enter Valid username';
                      return null;
                    },
                    onSaved: (val) {
                      _username = val;
                    },
                    decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  style: TextStyle(color: Colors.white),
                  onSaved: (val) {
                    _userPassword = val;
                  },
                  validator: (val) {
                    if (val.isEmpty || val.length < 6)
                      return 'Password must be of len 6';
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 10),
                if (!_isLogin)
                  SwitchListTile(
                    title: Text(
                      'Is Teacher',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _isTeacher,
                    onChanged: (bool value) async {
                      if (value) await createAlertDialog(context);
                      setState(() {
                        _isTeacher = value;
                      });
                    },
                    activeColor: Colors.green,
                    inactiveThumbColor: Colors.red,
                  ),
                if (widget.isLoading) CircularProgressIndicator(),
                if (!widget.isLoading)
                  RaisedButton(
                    onPressed: _subbmitted,
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                if (!widget.isLoading)
                  FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin ? 'Create new account' : 'Login',
                        style: TextStyle(color: Colors.white),
                      ))
              ],
            )),
      )),
    );
  }
}
