import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxe_auto/app_widgets/widgets.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'car.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String _defCarName;

  @override
  void initState() {
    super.initState();
    _initCarName();
  }

  Future<Null> _initCarName() async {
    String name = await getDefCarName();
    setState(() {
      _defCarName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              /// Appbar
              RoundTopbar(
                height: 76,
                width: size.width,
                color: Colors.red,
                roundness: 16.0,
                left: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    debugPrint('pressed on menu');
                  },
                ),
                title: Text(_defCarName),
                right: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    debugPrint('pressed on info');
                  },
                ),
              ),

              /// body
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('car').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error);

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return waitingWidget();

                    case ConnectionState.none:
                      return noConnectionWidget();

                    default:
                      return ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot snapshot) {
                          debugPrint(
                              '${snapshot[Car.brandKey]} ${snapshot[Car.nameKey]}');
                          return ListTile(
                            title: Text(
                                '${snapshot[Car.brandKey]} ${snapshot[Car.nameKey]}'),
                          );
                        }).toList(),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
