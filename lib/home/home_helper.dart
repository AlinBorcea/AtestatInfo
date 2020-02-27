import 'package:flutter/material.dart';
import '../models/tax.dart';
import '../database/firestore_helper.dart';

class HomeHelper {
  HomeHelper(this._firestoreHelper);

  final FirestoreHelper _firestoreHelper;

  /// Show dialogs area.
  void openAccountMenu() {
    /// TODO | create an account menu to log out and change account
  }

  void showEditTaxDialog(BuildContext context, Tax tax) {
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

  void showDeleteTaxDialog(BuildContext context, Tax tax) {
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
}
