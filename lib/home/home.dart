import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import '../app_widgets/widgets.dart';
import 'add_tax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tax.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Firebase related global variables.
  FirestoreHelper _firestoreHelper = FirestoreHelper();
  AuthHelper _authHelper = AuthHelper();
  FirebaseUser _user;

  /// TextEditingControllers used to edit a tax.

  @override
  void initState() {
    super.initState();
    _init();
  }

  /// Helper functions area.
  void _init() async {
    if (!await _authHelper.isLoggedIn()) {
      await _authHelper.signInWithGoogle();
      main();
    }
    _user = _authHelper.user;
    _firestoreHelper.uid = _user.uid;
    await _firestoreHelper.initCar();
    setState(() {});
  }

  /// Show dialogs area.
  void _openAccountMenu() {
    /// TODO | create an account menu to log out and change account
  }

  void _showEditTaxDialog(BuildContext context, Tax tax) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _valueController = TextEditingController();
    TextEditingController _currencyController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text('Edit tax'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Title'),
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Value'),
                  controller: _valueController,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Currency'),
                  controller: _currencyController,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  _titleController.dispose();
                  _valueController.dispose();
                  _currencyController.dispose();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _firestoreHelper.updateTax(
                      tax,
                      Tax(
                          _titleController.text,
                          int.parse(_valueController.text),
                          _currencyController.text));
                  _titleController.dispose();
                  _valueController.dispose();
                  _currencyController.dispose();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showDeleteTaxDialog(BuildContext context, Tax tax) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text('Are you sure you want to delete tax ${tax.title}?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  _firestoreHelper.deleteTax(tax);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  /// Backend helper functions

  /// UI.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// TODO | add app drawer
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header'),
            ),
            Text('Item'),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        )),
        title: Text('Taxes'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => _openAccountMenu(),
            child: CircleAvatar(
              minRadius: 15,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                minRadius: 10,
                child: Icon(Icons.account_circle),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            /// CarCard
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: _carImage(size.width),
            ),

            /// taxes
            Container(
              margin: EdgeInsets.only(top: 24.0),
              child: _taxesBody(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        /// TODO | create add_tax.dart
        //onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          //  builder: (context) => EditTax(_firestoreHelper.defCarName, 0))),
      ),
    );
  }

  Widget _carImage(double width) {
    return _firestoreHelper.defCarName == null
        // no cars
        ? Column(
            children: <Widget>[
              Icon(
                Icons.notifications_none,
                size: 64.0,
              ),
              Text('No cars!\nClick on the menu to add one!'),
            ],
          )
        // has at least one car
        /// TODO | create car menu
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

  Widget _taxesBody(BuildContext context) {
    return _firestoreHelper.defCarName == null
        ? null
        : StreamBuilder<QuerySnapshot>(
            stream: _firestoreHelper.getCarTaxesStream(),
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
                        onTap: () => _showEditTaxDialog(
                            context, Tax.fromMap(snapshot.data)),
                        onHorizontalDragStart: (details) =>
                            _showDeleteTaxDialog(
                                context, Tax.fromMap(snapshot.data)),
                        child: ListTile(
                          title: Text('${snapshot.data[Tax.titleKey]}'),
                          subtitle: Text(
                              '${snapshot.data[Tax.valueKey]} ${snapshot.data[Tax.currencyKey]}'),
                        ),
                      );
                    }).toList(),
                  );
              }
            },
          );
  }
}
