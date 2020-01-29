import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'car.dart';
import 'tax.dart';
import 'more_info.dart';
import 'utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxe_auto/database/firestore.dart';
import 'package:taxe_auto/app_widgets/round_topbar.dart';

class CarHome extends StatefulWidget {
  @override
  State createState() => new _CarHomeState();
}

class _CarHomeState extends State<CarHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          /// Appbar
          RoundTopbar(
            height: 86,
            width: size.width,
            color: Colors.red,
            roundness: 8,
            left: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                debugPrint('pressed on menu');
              },
            ),
            title: FutureBuilder(
              future: Firestore.instance.collection('extra').document('defcar').get(),
              initialData: 'Loading...',
              builder: (context, snapshot) {
                return Text(snapshot.data['name'], style: TextStyle(color: Colors.white),);
              },
            ),
            right: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                debugPrint('pressed on info');
              },
            ),
          ),
        ],
      ),
    );
  }
}
