import 'package:flutter/material.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import 'package:taxe_auto/home/main_page.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

/// [_finished] true if the user sign in process is finished.
/// [_isSignedIn] false if there is no user.
class _HomeState extends State<Home> {
  bool _finished = false;
  bool _isSignedIn;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    bool isSignedIn = await isLoggedIn();
    if (!isSignedIn)
      signInWithGoogle();

    isSignedIn = await isLoggedIn();
    setState(() {
      _isSignedIn = isSignedIn;
      _finished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _appBody(),
    );
  }

  Widget _appBody() {
    if (!_finished) return _signingInWidget();
    if (_isSignedIn) return MainPage('');
    return _signInErrorWidget();
  }

  Widget _signingInWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.assignment),
          Text('Signing in..'),
        ],
      ),
    );
  }

  Widget _signInErrorWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text('Error...'),
        ],
      ),
    );
  }

}
