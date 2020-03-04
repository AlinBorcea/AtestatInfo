import 'package:flutter/material.dart';
import 'tax.dart';

class Car {
  static const String brandKey = 'brand';
  static const String nameKey = 'name';
  static const String plateNumberKey = 'plateNumber';
  static const String colorKey = 'color';
  static const String manufactureYearKey = 'manufactureYear';
  static const String taxesKey = 'taxes';

  String _brand;
  String _name;
  String _plateNumber;
  int _colorCode;
  int _manufactureYear;
  List<Tax> _taxes;

  Car(this._brand, this._name, this._plateNumber, this._colorCode,
      this._manufactureYear, this._taxes);

  Car.fromMap(Map<String, dynamic> carMap) {
    _brand = carMap[brandKey];
    _name = carMap[nameKey];
    _plateNumber = carMap[plateNumberKey];
    _colorCode = Color(carMap[colorKey]).hashCode;
    _manufactureYear = carMap[manufactureYearKey];
    _taxes = carMap[taxesKey];
  }

  int get manufactureYear => _manufactureYear;

  int get color => _colorCode;

  String get plateNumber => _plateNumber;

  String get name => _name;

  String get brand => _brand;

  List<Tax> get taxes => _taxes;

  Map<String, dynamic> toMap() {
    return {
      brandKey: _brand,
      nameKey: _name,
      plateNumberKey: _plateNumber,
      colorKey: _colorCode,
      manufactureYearKey: _manufactureYear,
      taxesKey: _taxes,
    };
  }

}