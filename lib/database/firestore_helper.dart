import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxe_auto/models/tax.dart';
import '../models/car.dart';

class FirestoreHelper {
  CollectionReference _ref = Firestore.instance.collection('users');
  String _uid;
  String _defCarName;
  Color _color;

  Future<Null> initCar() async {
    if (_uid != null) {
      await _ref.document(_uid).get().then((snapshot) {
        _defCarName = snapshot.data['defCar'];
        _color = Color(int.parse(snapshot.data['color']));
      });
    }
  }

  void addCar(Car car) {
    _ref.document(_uid).collection('cars').add(car.toMap());

    _ref.document(_uid).setData({
      'defCar': '${car.brand} ${car.name}',
      'color': '${car.color.hashCode.toString()}',
    }, merge: true);
  }

  //Future<bool> carExists(Car car) {// TODO | check if car exists}

  set uid(String uid) => _uid = uid;

  String get defCarName => _defCarName;

  Color get carColor => _color;

  Future<String> getDefCarName() async {
    return await _ref.document(_uid).get().then((snapshot) {
      return snapshot.data['defCar'];
    });
  }

  Stream<QuerySnapshot> getCarStream() {
    return _ref.document(_uid).collection('cars').snapshots();
  }

  /// User related.
  Future<bool> userExists(FirebaseUser user) async {
    return _ref
        .where('uid', isEqualTo: '${user.uid}')
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      return snapshot.documents.length == 1;
    });
  }

  void addUser(FirebaseUser user) async {
    if (!await userExists(user))
      _ref.document(user.uid).setData({
        'uid': user.uid,
      });
  }
}
