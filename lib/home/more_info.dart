import 'package:flutter/material.dart';
import 'package:taxe_masina/home/car.dart';
import 'utils.dart';

class MoreInfo extends StatefulWidget {
  MoreInfo(this._car);

  final Car _car;

  @override
  State createState() => new _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 24.0),
                height: 86.0,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28.0),
                    bottomRight: Radius.circular(28.0),
                  ),
                ),
                child: topBar3(
                  'More Info',
                  Icons.arrow_back_ios,
                  () => Navigator.of(context).pop(),
                  Icons.mode_edit,
                  () => debugPrint(
                      'editing ${widget._car.brand} ${widget._car.name}'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 96.0, left: 4.0, right: 4.0),
                child: carCard(widget._car, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
