import 'package:flutter/material.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import 'package:taxe_auto/home/main_page.dart';
import 'package:taxe_auto/home/user_setup.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new _HomeState();
}

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
    setState(() {
      _isSignedIn = isSignedIn;
      _finished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_finished) return Text('Signing in...');
    if (_isSignedIn) return MainPage('');
    return RegisterUser();
  }

}
