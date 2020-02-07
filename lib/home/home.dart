import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taxe_auto/app_widgets/widgets.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'edit_tax.dart';

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
    debugPrint(_defCarName);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            /// CarCard
            Container(
              margin: EdgeInsets.only(top: 32.0),
              child: _carImage(size.width),
            ),

            /// taxes
            _taxesBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTax(_defCarName, 0))),
      ),
    );
  }

  Widget _carImage(double width) {
    return _defCarName == null
        ? Text('Loading')
        : CarView(
            background: 'images/porsche.jpg',
            height: 256.0,
            width: width,
            elevation: 8.0,
            roundness: 16.0,
            title: 'Porsche',
            titleStyle: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
            subtitle: _defCarName,
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
          );
  }

  Widget _taxesBody() {
    return _defCarName == null
        ? Text('Loading')
        : StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(_defCarName).snapshots(),
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
                      return ListTile(
                        title: Text('tax'),
                      );
                    }).toList(),
                  );
              }
            },
          );
  }
}
