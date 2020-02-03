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
        child: Column(
          children: <Widget>[
            /// CarCard
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: CarView(
                background: 'images/porsche.jpg',
                height: 256.0,
                width: size.width,
                elevation: 8.0,
                roundness: 16.0,
                title: 'Porsche',
                titleStyle: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
                subtitle: 'GTX 911 Coupé',
                subtitleStyle: TextStyle(fontSize: 22.0, color: Colors.white),

                icon1: Icons.menu,
                link1: 'Menu',
                fun1: () => debugPrint('menu'),

                icon2: Icons.change_history,
                link2: 'Change',
                fun2: () => debugPrint('change'),

                icon3: Icons.info,
                link3: 'Info',
                fun3: () => debugPrint('info'),
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
    );
  }
}
