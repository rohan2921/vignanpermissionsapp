import 'dart:io';

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
  var _userImageFile;

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
    if (valid) {
      _formKey.currentState.save();
      widget.onsubmit(_userEmail.trim(), _username.trim(), _userImageFile,
          _userPassword.trim(), _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
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
                        ? NetworkImage(
                            'https://1.bp.blogspot.com/-vNBAAu1z7_4/W2sfF_8XHjI/AAAAAAAACGY/EMU-8TLYbegf-Ywv8kMmv85YoHPaAZjNACLcBGAs/s1600/device-2018-08-08-094825.png')
                        : FileImage(_userImageFile),
                  ),
                if(!_isLogin)UserImagePicker(setImage),
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
                  decoration: InputDecoration(labelText: 'Email address'),
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
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (val) {
                    _userPassword = val;
                  },
                  validator: (val) {
                    if (val.isEmpty || val.length < 6)
                      return 'Password must be of len 6';
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 10),
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
                      child: Text(_isLogin ? 'Create new account' : 'Login'))
              ],
            )),
      )),
    );
  }
}
