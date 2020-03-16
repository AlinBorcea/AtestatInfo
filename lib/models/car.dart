import 'package:flutter/material.dart';
import 'tax.dart';

class Car {
  static const String ownerIdKey = 'owner';
  static const String brandKey = 'brand';
  static const String nameKey = 'name';
  static const String plateNumberKey = 'plateNumber';
  static const String colorKey = 'color';
  static const String manufactureYearKey = 'manufactureYear';
  static const String taxesKey = 'taxes';

  String _ownerId;
  String _brand;
  String _name;
  String _plateNumber;
  String _colorCode;
  String _manufactureYear;

  Car(this._ownerId, this._brand, this._name, this._plateNumber, this._colorCode,
      this._manufactureYear);

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

  String get color => _colorCode;

  String get plateNumber => _plateNumber;

  String get name => _name;

  String get brand => _brand;

  String nameFormat() => '$brand $name';

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
