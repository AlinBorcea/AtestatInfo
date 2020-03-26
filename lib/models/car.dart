import 'package:flutter/material.dart';
import 'tax.dart';

class Car {
  static const String ownerIdKey = 'owner';
  static const String brandKey = 'brand';
  static const String nameKey = 'name';
  static const String plateNumberKey = 'plateNumber';
  static const String colorKey = 'color';
  static const String manufactureYearKey = 'manufactureYear';

  String _ownerId;
  String _brand;
  String _name;
  String _plateNumber;
  String _colorCode;
  String _manufactureYear;

  Car(this._ownerId, this._brand, this._name, this._plateNumber,
      this._colorCode, this._manufactureYear);

  Car.fromMap(Map<dynamic, dynamic> carMap) {
    _ownerId = carMap[ownerIdKey];
    _brand = carMap[brandKey];
    _name = carMap[nameKey];
    _plateNumber = carMap[plateNumberKey];
    _colorCode = carMap[colorKey];
    _manufactureYear = carMap[manufactureYearKey];
  }

  String get ownerId => _ownerId;

  String get manufactureYear => _manufactureYear;

  Color get color => getColorFromCode(_colorCode);

  String get plateNumber => _plateNumber;

  String get name => _name;

  String get brand => _brand;

  String nameFormat() => '$brand $name';

  static Color getColorFromCode(String code) {
    switch (code) {
      case '1':
        return Colors.red;
      case '2':
        return Colors.pink;
      case '3':
        return Colors.purple;
      case '4':
        return Colors.deepPurple;
      case '5':
        return Colors.indigo;
      case '6':
        return Colors.blue;
      case '7':
        return Colors.lightBlue;
      case '8':
        return Colors.cyan;
      case '9':
        return Colors.teal;
      case '10':
        return Colors.green;
      case '11':
        return Colors.lightGreen;
      case '12':
        return Colors.lime;
      case '13':
        return Colors.yellow;
      case '14':
        return Colors.amber;
      case '15':
        return Colors.orange;
      case '16':
        return Colors.deepOrange;
      case '17':
        return Colors.brown;
      case '18':
        return Colors.grey;
      case '19':
        return Colors.blueGrey;
      case '20':
        return Colors.black;
      default:
        return Colors.red;
    }
  }

  static String getCodeFromColor(Color color) {
    if (color == Colors.red)
      return '1';
    if (color == Colors.pink)
      return '2';
    if (color == Colors.purple)
      return '3';
    if (color == Colors.deepPurple)
      return '4';
    if (color == Colors.indigo)
      return '5';
    if (color == Colors.blue)
      return '6';
    if (color == Colors.lightBlue)
      return '7';
    if (color == Colors.cyan)
      return '8';
    if (color == Colors.teal)
      return '9';
    if (color == Colors.green)
      return '10';
    if (color == Colors.lightGreen)
      return '11';
    if (color == Colors.lime)
      return '12';
    if (color == Colors.yellow)
      return '13';
    if (color == Colors.amber)
      return '14';
    if (color == Colors.orange)
      return '15';
    if (color == Colors.deepOrange)
      return '16';
    if (color == Colors.brown)
      return '17';
    if (color == Colors.grey)
      return '18';
    if (color == Colors.blueGrey)
      return '19';
    if (color == Colors.black)
      return '20';
    return '1';
  }

  Map<String, dynamic> toMap() {
    return {
      ownerIdKey: _ownerId,
      brandKey: _brand,
      nameKey: _name,
      plateNumberKey: _plateNumber,
      colorKey: _colorCode,
      manufactureYearKey: _manufactureYear,
    };
  }
}
