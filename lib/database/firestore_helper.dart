import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxe_auto/models/tax.dart';
import '../models/car.dart';

class FirestoreHelper {
  Firestore _firestore = Firestore.instance;
  String _uid;
  String _docId;
  Car _defCar;

  Future<Null> initCar() async {
    if (_uid != null) {
      await _firestore
          .collection('users')
          .document(_uid)
          .get()
          .then((snapshot) async {
        _defCar = Car.fromMap(snapshot.data['defCar']);
        //_docId = await findCarDocId(_defCar);
      });
    }
  }

  /*Future<String> findCarDocId(Car car) async {
    return await _firestore.
        .document(_uid)
        .collection('cars')
        .where(Car.brandKey, isEqualTo: car.brand)
        .where(Car.nameKey, isEqualTo: car.name)
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents[0].documentID;
    });
  }*/

  void setDefCar(Car car) {
    _firestore
        .collection('users')
        .document(_uid)
        .updateData({'defCar': car.toMap(), 'color': car.color});
  }

  void addCar(Car car) {
    _firestore.collection('cars').add(car.toMap());
    _firestore.collection('users').document(_uid).setData({
      'defCar': car.toMap(),
    }, merge: true);
  }

  void deleteCar(Car car) async {
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
    return _firestore
        .collection('cars')
        .where(Car.ownerIdKey, isEqualTo: _uid)
        .snapshots();
  }

  /// taxes
  void addTax(Tax tax) {
    _firestore.collection('taxes').add(tax.toMap());
  }

  Stream<QuerySnapshot> getTaxesStream() {
    return _firestore
        .collection('taxes')
        .where(Tax.ownerIdKey, isEqualTo: _uid)
        .where(Tax.carInfoKey, isEqualTo: _defCar.nameFormat())
        .snapshots();
  }

  set uid(String uid) => _uid = uid;

  String get uid => _uid;

  Car get defCar => _defCar;

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
