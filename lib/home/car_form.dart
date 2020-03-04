import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:taxe_auto/models/car.dart';
import '../database/firestore_helper.dart';

class CarForm extends StatefulWidget {
  CarForm(this._firestoreHelper);

  final FirestoreHelper _firestoreHelper;

  @override
  State createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  TextEditingController _brandController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _plateNumberController = TextEditingController();
  int _manufactureYear;
  Color _color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add a car'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              _addCar();
            },
          )
        ],
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: 'Brand'),
              controller: _brandController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Name'),
              controller: _nameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Plate number'),
              controller: _plateNumberController,
            ),
            RaisedButton(
              child: Text(
                'Pick year. Current: $_manufactureYear',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () => _showPickYear(context),
            ),
            RaisedButton(
              child: Text('Pick color'),
              color: _color,
              onPressed: () => _showColorPicker(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showPickYear(BuildContext context) {
    Picker(
        adapter: NumberPickerAdapter(
            data: [NumberPickerColumn(begin: 1980, end: 2020)]),
        delimiter: [
          PickerDelimiter(
              child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List<int> values) {
          setState(() {
            _manufactureYear = values.last + 1980;
          });
        }).showDialog(context);
  }

  void _showColorPicker(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text('Pick color'),
        actions: <Widget>[
          FlatButton(
            child: Text('Done'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        content: MaterialColorPicker(
          selectedColor: Colors.red,
          onColorChange: (Color newColor) {
            setState(() {
              _color = newColor;
            });
          },
        ),
      );
    });
  }

  void _addCar() {
    widget._firestoreHelper.addCar(Car(
        _brandController.text,
        _nameController.text,
        _plateNumberController.text,
        _color.hashCode,
        _manufactureYear,
        null));
  }
}
