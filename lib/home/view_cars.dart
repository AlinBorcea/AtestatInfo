import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/firestore_helper.dart';
import '../models/car.dart';

class ViewCars extends StatefulWidget {
  ViewCars(this._firestoreHelper);

  final FirestoreHelper _firestoreHelper;

  @override
  State createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  Map<String, dynamic> _carMap;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    Map<String, dynamic> temp = await widget._firestoreHelper.getCars();
    setState(() {
      _carMap = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Cars'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(itemBuilder: (context, i) {

        }),
      ),
    );
  }
}