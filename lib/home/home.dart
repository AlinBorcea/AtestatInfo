import 'package:flutter/material.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'package:taxe_auto/home/main_page.dart';
import 'package:taxe_auto/home/user_setup.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _defCarName;
  bool _hasUser;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    String name = await getDefCarName();
    bool hasUser = await isLoggedIn();
    setState(() {
      _defCarName = name;
      _hasUser = hasUser;
    });
  }

  @override
  Widget build(BuildContext context) =>
      _hasUser ? MainPage(_defCarName) : UserSetup();
}
