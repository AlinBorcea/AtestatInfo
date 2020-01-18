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
