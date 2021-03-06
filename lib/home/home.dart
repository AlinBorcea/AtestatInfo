import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taxe_auto/database/firestore_helper.dart';
import 'package:taxe_auto/database/auth_helper.dart';
import 'package:taxe_auto/home/view_cars.dart';
import '../app_widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tax.dart';
import 'tax_form.dart';
import '../main.dart';
import 'car_form.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Firebase related global variables.
  FirestoreHelper _firestoreHelper = FirestoreHelper();
  AuthHelper _authHelper = AuthHelper();

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

    if (_authHelper.user == null) {
      main();
    } else {
      _firestoreHelper.uid = _authHelper.user.uid;
      await _firestoreHelper.initCar();
      setState(() {});
    }
  }

  /// UI.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: _primaryColor(),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        )),
        title: Text(_homeTitle()),
        actions: <Widget>[
          IconButton(
            icon: _authHelper.user != null
                ? CircleAvatar(
                    child: Image.network(
                        _authHelper.user.providerData[0].photoUrl),
                    minRadius: 32.0,
                  )
                : Icon(Icons.hourglass_empty),
            onPressed: () {
              _showLogOutDialog(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          /// CarCard
          Container(
            margin: EdgeInsets.only(top: 4.0),
            child: _carImage(size.width),
          ),

          /// taxes
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: _taxesBody(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: _primaryColor(),
        onPressed: () {
          if (_authHelper.user != null)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TaxForm(_firestoreHelper, null)));
        },
      ),
    );
  }

  String _homeTitle() {
    if (_authHelper.user == null) return 'No user!';
    if (_firestoreHelper.defCar != null) return _firestoreHelper.defCar.name;
    return 'Loading';
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: SvgPicture.asset('svg/user.svg')),
              ],
            ),
          ),
          _drawerButton('View cars', () {
            if (_authHelper.user != null)
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewCars(_firestoreHelper)));
          }),
          _drawerLine(),
          _drawerButton('Add a car', () {
            if (_authHelper.user != null)
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CarForm(_firestoreHelper)));
          }),
          _drawerLine(),
        ],
      ),
    );
  }

  Widget _drawerButton(String text, Function function) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
      onPressed: () => function(),
    );
  }

  Widget _drawerLine() {
    return SizedBox.fromSize(
      child: Container(
        color: _primaryColor(),
      ),
      size: Size(double.infinity, 1.0),
    );
  }

  Widget _carImage(double width) {
    return _firestoreHelper.defCar == null
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
            backgroundImage: SvgPicture.asset(
              'svg/car.svg',
              color: _primaryColor(),
            ),
            height: 256.0,
            width: width,
            elevation: 8.0,
            roundness: 16.0,
          );
  }

  Widget _taxesBody(BuildContext context) {
    return _firestoreHelper.defCar == null
        ? null
        : StreamBuilder<QuerySnapshot>(
            stream: _firestoreHelper.getTaxesStream(),
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
                    children: snapshot.data.documents.map((snapshot) {
                      return GestureDetector(
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

  void _showLogOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text('Are you sure you want to log out?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () async {
                  await _authHelper.signOut();
                  exit(0);
                },
              ),
            ],
          );
        });
  }

  Color _primaryColor() => _firestoreHelper.defCar == null
      ? Colors.blue
      : _firestoreHelper.defCar.color;
}
