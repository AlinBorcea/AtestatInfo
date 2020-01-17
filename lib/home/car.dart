import 'package:flutter/material.dart';

class Car {
  static const String brandKey = 'brand';
  static const String nameKey = 'name';
  static const String plateNumberKey = 'plateNumber';
  static const String colorKey = 'color';
  static const String manufactureYearKey = 'manufactureYear';

  String _brand;
  String _name;
  String _plateNumber;
  Color _color;
  int _manufactureYear;

  Car(this._brand, this._name, this._plateNumber, this._color,
      this._manufactureYear);

  Car.fromMap(Map<String, dynamic> carMap) {
    _brand = carMap[brandKey];
    _name = carMap[nameKey];
    _plateNumber = carMap[plateNumberKey];
    _color = Color(carMap[colorKey]);
    _manufactureYear = carMap[manufactureYearKey];
  }

  int get manufactureYear => _manufactureYear;

  Color get color => _color;

  String get plateNumber => _plateNumber;

  String get name => _name;

  String get brand => _brand;

  Map<String, dynamic> toMap() {
    return {
      brandKey: _brand,
      nameKey: _name,
      plateNumberKey: _plateNumber,
      colorKey: _color,
      manufactureYearKey: _manufactureYear,
    };
  }

}