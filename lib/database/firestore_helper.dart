import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import 'package:taxe_auto/models/tax.dart';

class FirestoreHelper {
  Firestore _firestore = Firestore.instance;
  String _uid;
  String _defCarName;

  Future<Null> initCar() async {
    _defCarName = await getDefCarName();
    debugPrint(_defCarName);
  }

  set uid(String uid) => _uid = uid;

  String get defCarName => _defCarName;

  Future<String> getDefCarName() async {
    return await _firestore
        .collection('users')
        .document(_uid)
        .get()
        .then((snapshot) {
      return snapshot.data['defCar'];
    });
  }

  Stream<QuerySnapshot> getCarTaxes() {
    return _firestore.collection('users').document(_uid)
        .collection(_defCarName)
        .snapshots();
  }

  Future<Null> addTax(Tax tax, String collection) async {
    await _firestore
        .collection(collection)
        .document(tax.title)
        .setData(tax.toMap());
  }

  Future<Null> updateTax(Tax tax, String collection) async {
    await _firestore
        .collection(collection)
        .document(tax.title)
        .updateData(tax.toMap());
  }

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
