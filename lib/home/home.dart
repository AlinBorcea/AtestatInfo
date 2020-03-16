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
import '../models/car.dart';

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
    _firestoreHelper.uid = _authHelper.user.uid;
    await _firestoreHelper.initCar();
    setState(() {});
  }

  /// UI.
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: _drawer(),
      appBar: AppBar(
        backgroundColor: _getColor(),
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
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TaxForm(_firestoreHelper, null))),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Icon(
                Icons.settings_applications,
                size: 128.0,
              ),
            ),
          ),
          _drawerButton('View cars', () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewCars(_firestoreHelper)));
          }),
          _drawerLine(),
          _drawerButton('Add a car', () {
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
        color: Colors.blue,
      ),
      size: Size(double.infinity, 4.0),
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
            background: 'images/porsche.jpg',
            height: 256.0,
            width: width,
            elevation: 8.0,
            roundness: 16.0,
            title: _firestoreHelper.defCar.brand,
            titleStyle: TextStyle(
              fontSize: 32.0,
              color: Colors.white,
            ),
            subtitle: _firestoreHelper.defCar.name,
            subtitleStyle: TextStyle(fontSize: 22.0, color: Colors.white),
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
                  //_firestoreHelper.deleteTax(tax);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Color _getColor() {
    if (_firestoreHelper.defCar != null) if (_firestoreHelper.defCar.color !=
        null) return Color(int.parse(_firestoreHelper.defCar.color));
    return Colors.blue;
  }
}
