import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taxe_auto/models/tax.dart';

final Firestore _fireStore = Firestore.instance;

Future<String> getDefCarName() async {
  var ds = await _fireStore.collection('def').document('defcar').get();
  return ds.data['name'];
}

Future<Null> addTax(Tax tax, String collection) async {
  await _fireStore
      .collection(collection)
      .document(tax.name)
      .setData(tax.toMap());
}

Future<Null> updateTax(Tax tax, String collection) async {
  await _fireStore
      .collection(collection)
      .document(tax.name)
      .updateData(tax.toMap());
}
