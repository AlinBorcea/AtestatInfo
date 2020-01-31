import 'package:flutter/material.dart';
import 'package:taxe_auto/home/car.dart';

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
              /// top bar
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
                child: null,
              ),
              /// car info
              Container(
                margin: EdgeInsets.only(top: 96.0, left: 4.0, right: 4.0),
                color: Colors.red,
                height: 256.0,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 64,
                      backgroundColor: Colors.teal,
                      child: CircleAvatar(
                        minRadius: 58,
                        child: Icon(Icons.directions_car, size: 86,),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text('${widget._car.brand} ${widget._car.name}', 
                    style: TextStyle(color: Colors.white, fontSize: 24),),
                    SizedBox(height: 4,),
                    Text('${widget._car.plateNumber}',
                     style: TextStyle(color: Colors.white, fontSize: 18),),
                    SizedBox(height: 4,),
                    Text('${widget._car.manufactureYear}',
                     style: TextStyle(color: Colors.white, fontSize: 14),),
                ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('You might find something here!'),
                    GestureDetector(
                      onTap: () {
                        _openLink('https://youtube.com/volkswagen');
                      },
                      child: ListTile(
                        title: Text('YouTube', 
                        style: TextStyle(fontSize: 24),),
                        subtitle: Text('https://youtube.com/volkswagen',
                         style: TextStyle(fontSize: 18, 
                         color: Colors.lightBlueAccent),),
                    ),
                    ),
                  ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openLink(String link) async {
    debugPrint(link);
  }

}
