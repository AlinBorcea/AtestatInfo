import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taxe_auto/models/tax.dart';
import '../models/car.dart';

class FirestoreHelper {
  Firestore _firestore = Firestore.instance;
  String _uid;
  String _defCarName;

  Future<Null> initCar() async {
    _defCarName = await getDefCarName();
  }

  void addCar(Car car) {
    _firestore.collection('users').document(_uid).setData({
      '${car.brand} ${car.name}': car.toMap(),
    }, merge: true);

    _firestore.collection('users').document(_uid).updateData({
      'defCar': '${car.brand} ${car.name}',
    });
  }

  //Future<bool> carExists(Car car) {// TODO | check if car exists}

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

  Stream<QuerySnapshot> getCarTaxesStream() {
    return _firestore
        .collection('users')
        .document(_uid)
        .collection(_defCarName)
        .snapshots();
  }

  Future<Map<String, dynamic>> getCars() async {
    return await _firestore
        .collection('users')
        .document(_uid)
        .get()
        .then((snapshot) {
      snapshot.data.remove('defCar');
      return snapshot.data;
    });
  }

  void addTax(Tax tax) {
    _firestore
        .collection('users')
        .document(_uid)
        .collection(_defCarName)
        .add(tax.toMap());
  }

  void updateTax(Tax oldTax, Tax newTax) {
    deleteTax(oldTax);
    addTax(newTax);
  }

  void deleteTax(Tax tax) {
    _firestore
        .collection('users')
        .document(_uid)
        .collection(_defCarName)
        .document(tax.title)
        .delete();
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
