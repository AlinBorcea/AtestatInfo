import 'package:flutter/material.dart';

Widget waitingWidget() {
  return Icon(Icons.cloud_download);
}

Widget noConnectionWidget() {
  return Icon(Icons.not_interested);
}

/// CarView is a custom widget used to display and manipulate the info about a car.
class CarView extends StatefulWidget {
  CarView({
    @required this.backgroundImage,
    @required this.height,
    @required this.width,
    @required this.elevation,
    @required this.roundness,
  });

  final double height;
  final double width;
  final double elevation;
  final double roundness;

  final Widget backgroundImage;

  @override
  State createState() => _CarViewState();
}

class _CarViewState extends State<CarView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.roundness),
      ),
      child: Column(
        children: <Widget>[
          /// CarCard
          Container(
            constraints: BoxConstraints.expand(
              height: widget.height,
            ),

            child: Stack(
              children: <Widget>[
                Positioned.fill(child: widget.backgroundImage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
