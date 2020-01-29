import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:taxe_auto/home/car.dart';

const String carPath = 'car';

Future<Car> getDefCar(String name) async {
  DocumentSnapshot ds = await Firestore.instance.collection(carPath).document(name).get();
  return new Car.fromMap(ds.data);
}

Future<String> getDefCarName() async {
  var ds = await Firestore.instance.collection('extra').document('defcar').get();
  var str = ds.data['name'];
  debugPrint(str);
  return str.toString();
}
