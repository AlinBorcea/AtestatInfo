import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/firestore_helper.dart';
import '../models/car.dart';
import '../models/tax.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaxForm extends StatefulWidget {
  TaxForm(this._firestoreHelper, this._tax);

  final FirestoreHelper _firestoreHelper;
  final Tax _tax;

  @override
  State createState() => _TaxFormState();
}

class _TaxFormState extends State<TaxForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _valueController = TextEditingController();
  TextEditingController _currencyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add a tax'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _addTax(),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: new BorderRadius.circular(25.7),
              ),
            ),
            controller: _nameController,
          ),
          SizedBox(
            height: 4.0,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Value',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: new BorderRadius.circular(25.7),
              ),
            ),
            controller: _valueController,
          ),
          SizedBox(
            height: 4.0,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Currency',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: new BorderRadius.circular(25.7),
              ),
            ),
            controller: _currencyController,
          ),
        ],
      ),
    );
  }

  bool _taxIsValid() {
    bool isNum = true;
    try {
      int.parse(_valueController.text);
    } catch (e) {
      isNum = false;
    }

    if (!isNum) {
      _showToast('Tax value must be a number');
      return false;
    } else if (int.parse(_valueController.text) < 0) {
      _showToast('Value must be greater than 0');
      return false;
    }

    return _nameController.text.isNotEmpty &&
        _currencyController.text.isNotEmpty;
  }

  void _addTax() async {
    if (_taxIsValid()) {
      widget._firestoreHelper.addTax(Tax(
          widget._firestoreHelper.uid,
          widget._firestoreHelper.defCar.nameFormat(),
          _nameController.text.toString(),
          _valueController.text.toString(),
          'Euro'));
      _showToast('Tax added!');
    } else {
      _showToast('Tax could not be added');
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
