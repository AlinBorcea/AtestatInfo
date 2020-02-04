import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getDefCarName() async {
  var ds = await Firestore.instance.collection('def').document('defcar').get();
  return ds.data['name'];
}
