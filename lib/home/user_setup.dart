import 'package:flutter/material.dart';
import '../database/auth_helper.dart';

class RegisterUser extends StatefulWidget {
  @override
  State createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  bool wasSuccessful;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Google sign in'),
              onPressed: () => _signIn(),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    wasSuccessful = await signInWithGoogle();
    debugPrint('Sign in -> $wasSuccessful');
  }
}
