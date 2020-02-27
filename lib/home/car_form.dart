import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CarForm extends StatefulWidget {
  @override
  State createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  TextEditingController _brandController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _plateNumberController = TextEditingController();
  int _manufactureYear;
  Color _color;

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
              debugPrint('Done!');
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
            NumberPicker.integer(
              highlightSelectedValue: true,
              initialValue: 2020,
              minValue: 1980,
              maxValue: 2020,
              onChanged: (num) {
                setState(() {
                  _manufactureYear = num;
                });
              },
            ),
            ColorPicker(
              pickerColor: Colors.blue,
              onColorChanged: (newColor) {
                setState(() {
                  _color = newColor;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
