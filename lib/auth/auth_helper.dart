import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHelper extends StatefulWidget {

  @override
  State createState() => _AuthHelperState();
}

class _AuthHelperState extends State<AuthHelper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Create account with Google'),
              onPressed: () => _registerUser(),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser() async {

  }

}