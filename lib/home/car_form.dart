import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:taxe_auto/main.dart';
import 'package:taxe_auto/models/car.dart';
import '../database/firestore_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  int _manufactureYear = 2008;
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// styling
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.7),
        ),
        backgroundColor: _color,
        centerTitle: true,

        /// actions
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add a car', style: TextStyle(shadows: [
          Shadow(
              color: Colors.black, offset: Offset.zero, blurRadius: 1.0)
        ], color: _color == Colors.white ? Colors.black : Colors.white),),
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
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          children: <Widget>[
            /// brand
            TextField(
              decoration: InputDecoration(
                hintText: 'Brand',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _color),
                  borderRadius: new BorderRadius.circular(25.7),
                ),
              ),
              controller: _brandController,
            ),
            SizedBox(height: 4.0,),
            /// name
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _color),
                  borderRadius: new BorderRadius.circular(25.7),
                ),
              ),
              controller: _nameController,
            ),
            SizedBox(height: 4.0,),
            /// plate num
            TextField(
              decoration: InputDecoration(
                hintText: 'Plate number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: _color),
                  borderRadius: new BorderRadius.circular(25.7),
                ),
              ),
              controller: _plateNumberController,
            ),

            /// manufacture year
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.7)),
              child: Text(
                'Pick year. Current: $_manufactureYear',
                style: TextStyle(shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset.zero, blurRadius: 1.0)
                ], color: _color == Colors.white ? Colors.black : Colors.white),
              ),
              color: _color,
              onPressed: () => _showPickYear(context),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.7)),
              child: Text(
                'Pick color',
                style: TextStyle(shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset.zero, blurRadius: 1.0)
                ], color: _color == Colors.white ? Colors.black : Colors.white),
              ),
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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
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

  bool _dataIsValid() =>
      _brandController.text.isNotEmpty &&
      _nameController.text.isNotEmpty &&
      _plateNumberController.text.isNotEmpty;

  void _addCar() {
    if (_dataIsValid()) {
      widget._firestoreHelper.addCar(Car(
          _brandController.text,
          _nameController.text,
          _plateNumberController.text,
          _color.hashCode,
          _manufactureYear,
          null));

      _showToast('Car was added');
      Navigator.of(context).pop();
      main();
    } else {
      _showToast('Invalid data!');
    }
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: _color,

      textColor: _color == Colors.white ? Colors.black : Colors.white,
      fontSize: 16.0,
    );
  }
}
