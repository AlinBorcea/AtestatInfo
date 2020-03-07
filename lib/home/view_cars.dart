import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/firestore_helper.dart';
import '../models/car.dart';
import '../app_widgets/widgets.dart';

class ViewCars extends StatefulWidget {
  ViewCars(this._firestoreHelper);

  final FirestoreHelper _firestoreHelper;

  @override
  State createState() => _ViewCarsState();
}

class _ViewCarsState extends State<ViewCars> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Cars'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: widget._firestoreHelper.getCarStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text(snapshot.error);

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return waitingWidget();

                case ConnectionState.none:
                  return noConnectionWidget();

                default:
                  return Column(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot snapshot) {
                      return GestureDetector(
                          child: ExpansionTile(
                        title: Text(
                            '${snapshot.data[Car.brandKey]} ${snapshot.data[Car.nameKey]}'),
                        children: <Widget>[
                          Text(_carInfo(snapshot.data)),
                        ],
                      ));
                    }).toList(),
                  );
              }
            }),
      ),
    );
  }

  String _carInfo(Map<String, dynamic> map) {
    String str = '';
    map.forEach((k, v) {
      str += '$k: $v\n';
    });
    return str;
  }
}
