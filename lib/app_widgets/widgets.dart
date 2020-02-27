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
    @required this.background,
    @required this.title,
    @required this.height,
    @required this.width,
    @required this.elevation,
    @required this.roundness,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });

  final double height;
  final double width;
  final double elevation;
  final double roundness;

  final String background;
  final String title;
  final String subtitle;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

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

            /// image
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.background),
                fit: BoxFit.fill,
              ),
            ),

            /// Text
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 16.0,
                  bottom: 24.0,
                  child: Text(
                    widget.title,
                    style: widget.titleStyle,
                  ),
                ),
                Positioned(
                  left: 16.0,
                  bottom: 0.0,
                  child: Text(
                    widget.subtitle,
                    style: widget.subtitleStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
