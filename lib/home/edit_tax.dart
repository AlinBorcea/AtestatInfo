import 'package:flutter/material.dart';
import 'tax.dart';
import 'package:taxe_auto/database/firestore_helper.dart';

class EditTax extends StatefulWidget {
  EditTax(this._collection, this._operation);

  final String _collection;
  final int _operation;
  static int addOperation = 0;
  static int editOperation = 1;

  @override
  State createState() => _EditTaxState();
}

class _EditTaxState extends State<EditTax> {
  List<TextEditingController> _nameControllers = List();
  List<TextEditingController> _valueControllers = List();
  List<Widget> _taxFieldWidgets = List();
  String _title;

  @override
  void initState() {
    super.initState();
    _addField();
    _title =
        widget._operation == EditTax.addOperation ? 'Add a tax' : 'Edit tax';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () => _editData(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          /// TextFields
          Column(
            children: _taxFieldWidgets,
          ),

          /// add/remove buttons
          Container(
            margin: EdgeInsets.only(top: 8.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.minimize,
                    size: 32.0,
                  ),
                  onPressed: () {
                    _removeField();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    size: 32.0,
                  ),
                  onPressed: () {
                    _addField();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _removeField() {
    setState(() {
      _taxFieldWidgets.removeLast();
      _nameControllers.removeLast();
      _valueControllers.removeLast();
    });
  }

  void _addField() {
    var _nameController = TextEditingController();
    var _valueController = TextEditingController();
    setState(() {
      _nameControllers.add(_nameController);
      _valueControllers.add(_valueController);
      _taxFieldWidgets.add(Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _nameController,
              ),
            ),
            Text(' : '),
            Expanded(
                child: TextField(
              controller: _valueController,
            )),
          ],
        ),
      ));
    });
  }

  void _editData() async {
    if (widget._operation == EditTax.addOperation) {
      for (int i = 0; i < _nameControllers.length; i++)
        addTax(Tax(_nameControllers[i].text, _valueControllers[i].text),
            widget._collection);
    } else {
      for (int i = 0; i < _nameControllers.length; i++)
        updateTax(Tax(_nameControllers[i].text, _valueControllers[i].text),
            widget._collection);
    }
  }
}
