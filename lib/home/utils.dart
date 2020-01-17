import 'package:flutter/material.dart';
import 'car.dart';

Widget topBar3(
    String title, IconData ic1, Function f1, IconData ic2, Function f2) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.00),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            ic1,
            color: Colors.white,
          ),
          onPressed: () => f1(),
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: Icon(
            ic2,
            color: Colors.white,
          ),
          onPressed: () => f2(),
        ),
      ],
    ),
  );
}

Widget carCard(Car car, BuildContext context) {
  TextStyle infoStyle = new TextStyle(fontSize: 18.0);
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Container(
      margin: EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0, right: 2.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Producator: ${car.brand}', style: infoStyle),
          Divider(),
          Text('Nume: ${car.name}', style: infoStyle,),
          Divider(),
          Text('An fabricare: ${car.manufactureYear}', style: infoStyle),
          Divider(),
          Text('Culoare: ${car.color.toString()}', style: infoStyle,),
          Divider(),
          Text('Numar inmatriculare: ${car.plateNumber}', style: infoStyle,),
        ],
      ),
    ),
  );
}
