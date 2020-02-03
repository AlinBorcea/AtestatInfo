import 'package:flutter/material.dart';
import 'package:taxe_auto/home/home.dart';
import 'package:taxe_auto/home/car.dart';

void main() {
  runApp(MaterialApp(
    title: 'Taxe Auto',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Home(),
  ));
}
