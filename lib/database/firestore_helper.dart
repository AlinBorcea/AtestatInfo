import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxe_auto/models/tax.dart';
import '../models/car.dart';

class FirestoreHelper {
  Firestore _firestore = Firestore.instance;
  StreamSubscription _streamSubscription;
  String _uid;
  Car _defCar;

  Future<Null> initCar() async {
    if (_uid != null) {
      _defCar = Car.fromMap(await _firestore
          .collection('users')
          .document(_uid)
          .get()
          .then((snap) {
        return snap.data['defCar'];
      }));
      _streamSubscription = _firestore
          .collection('users')
          .document(_uid)
          .snapshots()
          .listen((onData) {
        _defCar = Car.fromMap(onData.data['defCar']);
      });
    }
  }

  set uid(String uid) => _uid = uid;

  String get uid => _uid;

  Car get defCar => _defCar;

  void setDefCar(Car car) {
    _firestore
        .collection('users')
        .document(_uid)
        .updateData({'defCar': car.toMap()});
  }

  void addCar(Car car) {
    _firestore.collection('cars').add(car.toMap());
    _firestore.collection('users').document(_uid).setData({
      'defCar': car.toMap(),
    }, merge: true);
  }

  void deleteCar(Car car) async {
    if (_uid != null) {
      if (_defCar.nameFormat() == car.nameFormat())
        _firestore.collection('users').document(_uid).updateData({
          'defCar': {'brand': 'none', 'name': 'none', 'color': '0xFF2196F3'}
        });

      _firestore
          .collection('cars')
          .where(Car.ownerIdKey, isEqualTo: _uid)
          .where(Car.brandKey, isEqualTo: car.brand)
          .where(Car.nameKey, isEqualTo: car.name)
          .getDocuments()
          .then((snapshots) {
        if (snapshots.documents.length > 0) {
          snapshots.documents[0].reference.delete();
          debugPrint(snapshots.documents.length.toString());
        }
      });
    }
  }

  Future<Car> getDefCar() async {
    return await _firestore
        .collection('users')
        .document(_uid)
        .get()
        .then((snapshot) {
      return snapshot.data['defCar'];
    });
  }

  Stream<QuerySnapshot> getCarStream() {
    return _uid == null
        ? null
        : _firestore
            .collection('cars')
            .where(Car.ownerIdKey, isEqualTo: _uid)
            .snapshots();
  }

  /// taxes
  void addTax(Tax tax) {
    _firestore.collection('taxes').add(tax.toMap());
  }

  Stream<QuerySnapshot> getTaxesStream() {
    return _uid == null ? null : _firestore
        .collection('taxes')
        .where(Tax.ownerIdKey, isEqualTo: _uid)
        .where(Tax.carInfoKey, isEqualTo: _defCar.nameFormat())
        .snapshots();
  }

  void deleteTax(Tax tax) {
    if (_uid != null) {
      _firestore
          .collection('taxes')
          .where(Tax.ownerIdKey, isEqualTo: _uid)
          .where(Tax.carInfoKey, isEqualTo: tax.carInfo)
          .where(Tax.titleKey, isEqualTo: tax.title)
          .where(Tax.valueKey, isEqualTo: tax.value)
          .where(Tax.currencyKey, isEqualTo: tax.currency)
          .snapshots()
          .first
          .then((snap) {
        snap.documents[0].reference.delete();
      });
    }
  }

  /// User related.
  Future<bool> userExists(FirebaseUser user) async {
    return _firestore
        .collection('users')
        .where('uid', isEqualTo: '${user.uid}')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      return snapshot.documents.length == 1;
    });
  }

  void addUser(FirebaseUser user) async {
    if (!await userExists(user))
      _firestore.collection('users').document(user.uid).setData({
        'uid': user.uid,
      });
  }
}
