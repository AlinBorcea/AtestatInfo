import 'package:flutter/material.dart';
import '../database/firestore_helper.dart';
import '../models/car.dart';
import '../models/tax.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add a tax'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _addTax();
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'Name',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: new BorderRadius.circular(25.7),
              ),
            ),
            //controller: _nameController,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Value',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: new BorderRadius.circular(25.7),
              ),
            ),
            //controller: _nameController,
          ),
        ],
      ),
    );
  }

  bool _taxIsValid() => true;

  void _addTax() async {
    if (_taxIsValid())
      widget._firestoreHelper.addTax(Tax(
          widget._firestoreHelper.uid,
          widget._firestoreHelper.defCar.nameFormat(),
          _nameController.text,
          _valueController.text,
          'Euro'));
    else
      debugPrint('=> invalid tax');
  }
}
