import 'package:flutter/material.dart';
import 'package:taxe_masina/home/car_home.dart';
import 'package:taxe_masina/home/car.dart';

void main() {
  Car car = new Car('Volkswagen', 'Golf 4', 'AR 05 RAH', Colors.red, 1998);
  runApp(MaterialApp(
    title: 'Taxe Masina',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    home: CarHome(car),
  ));
}