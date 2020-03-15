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

  bool _taxIsValid() {
    bool isInt = true;
    try {
      int.parse(_valueController.text);
    } catch(exception) {
      isInt = false;
    }
    return _nameController.text.isNotEmpty && isInt;
  }

  void _addTax() {
    if (_taxIsValid())
      widget._firestoreHelper.addTax(Tax(_nameController.text, int.parse(_valueController.text), 'Euro'));
  }

}