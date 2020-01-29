import 'package:flutter/material.dart';
import 'package:taxe_auto/home/car_home.dart';
import 'package:taxe_auto/home/car.dart';

void main() {
  runApp(MaterialApp(
    title: 'Taxe Auto',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: CarHome(),
  ));
}
