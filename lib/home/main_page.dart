import 'package:flutter/material.dart';
import '../app_widgets/widgets.dart';
import 'edit_tax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tax.dart';

class MainPage extends StatefulWidget {
  MainPage(this._defCarName);

  final String _defCarName;

  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
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
            Container(
              margin: EdgeInsets.only(top: 24.0),
              child: _taxesBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EditTax(widget._defCarName, 0))),
      ),
    );
  }

  Widget _carImage(double width) {
    return widget._defCarName == null
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
      subtitle: widget._defCarName,
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
    return widget._defCarName == null
        ? Text('Loading')
        : StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(widget._defCarName).snapshots(),
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
                  leading: Icon(Icons.local_taxi),
                  title: Text('${snapshot.data[Tax.nameKey]}'),
                  subtitle: Text('${snapshot.data[Tax.valueKey]}'),
                );
              }).toList(),
            );
        }
      },
    );
  }
}