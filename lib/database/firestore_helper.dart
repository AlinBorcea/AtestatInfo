import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taxe_auto/home/tax.dart';

Future<String> getDefCarName() async {
  var ds = await Firestore.instance.collection('def').document('defcar').get();
  return ds.data['name'];
}

Future<Null> addTax(Tax tax, String collection) async {
  await Firestore.instance
      .collection(collection)
      .document(tax.name)
      .setData(tax.toMap());
}

Future<Null> updateTax(Tax tax, String collection) async {
  await Firestore.instance
      .collection(collection)
      .document(tax.name)
      .updateData(tax.toMap());
}
