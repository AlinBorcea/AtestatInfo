import 'package:flutter/material.dart';
import '../database/auth_helper.dart';

class UserSetup extends StatefulWidget {
  @override
  State createState() => _UserSetupState();
}

class _UserSetupState extends State<UserSetup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setup'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Register'),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => _RegisterUser())),
            )
          ],
        ),
      ),
    );
  }
}

class _RegisterUser extends StatefulWidget {
  @override
  State createState() => _RegisterUserState();
}

class _RegisterUserState extends State<_RegisterUser> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: 'Email'),
            controller: _emailController,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Password'),
            controller: _passwordController,
          ),
          RaisedButton(
              child: Text('Register'),
              onPressed: () async {
                bool wasSuccessful = await registerUser(
                    _emailController.text, _passwordController.text);
                debugPrint('Register -> $wasSuccessful');
              }),
        ],
      ),
    );
  }
}
