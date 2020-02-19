import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import '../app_widgets/widgets.dart';
import 'edit_tax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tax.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirestoreHelper _firestoreHelper = FirestoreHelper();
  AuthHelper _authHelper = AuthHelper();
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (!await _authHelper.isLoggedIn()) {
      await _authHelper.signInWithGoogle();
    }
    _user = _authHelper.user;
    _firestoreHelper.uid = _user.uid;
    await _firestoreHelper.initCar();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(Icons.menu),
        title: Text('Taxes'),
        actions: <Widget>[
          GestureDetector(
            child: CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                minRadius: 15,
                maxRadius: 15,
                child: Icon(Icons.account_circle),
              ),
            ),
          ),
        ],
      ),
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
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTax(_firestoreHelper.defCarName, 0))),
      ),
    );
  }

  Widget _carImage(double width) {
    return _firestoreHelper.defCarName == null
    // no cars
        ? Column(
      children: <Widget>[
        Icon(Icons.notifications_none, size: 64.0,),
        Text('No cars!\nClick on the menu to add one!'),
      ],
    )
    // has at least one car
        : CarView(
      background: 'images/porsche.jpg',
      height: 256.0,
      width: width,
      elevation: 8.0,
      roundness: 16.0,
      title: '',
      titleStyle: TextStyle(
        fontSize: 32.0,
        color: Colors.white,
      ),
      subtitle: _firestoreHelper.defCarName,
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
    return _firestoreHelper.defCarName == null
        ? null
        : StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(_firestoreHelper.defCarName)
          .snapshots(),
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
