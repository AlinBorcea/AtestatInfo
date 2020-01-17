import 'package:flutter/material.dart';
import 'car.dart';
import 'more_info.dart';
import 'utils.dart';

class CarHome extends StatefulWidget {
  CarHome(this._car);

  final Car _car;

  @override
  State createState() => new _CarHomeState();
}

class _CarHomeState extends State<CarHome> {
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
                height: 86,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(28),
                    bottomLeft: Radius.circular(28),
                  ),
                ),
                child: topBar3(
                    widget._car.name, Icons.menu, null, Icons.info, () => Navigator.of(context)
                    .push(new MaterialPageRoute(builder: (context) => new MoreInfo(widget._car)))),
              ),
              Container(
                height: size.height,
                padding: EdgeInsets.only(top: 80),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
