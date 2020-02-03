import 'package:flutter/material.dart';

class RoundTopbar extends StatefulWidget {
  RoundTopbar({
    @required this.height,
    @required this.width,
    @required this.color,
    @required this.roundness,
    this.left,
    @required this.title,
    this.right,
  });

  final double height;
  final double width;
  final Color color;
  final double roundness;
  final Widget left;
  final Widget title;
  final Widget right;

  @override
  State createState() => _RoundTopbarState();
}

class _RoundTopbarState extends State<RoundTopbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(widget.roundness),
          bottomRight: Radius.circular(widget.roundness),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.left,
          widget.title,
          widget.right,
        ],
      ),
    );
  }
}

Widget waitingWidget() {
  return Icon(Icons.cloud_download);
}

Widget noConnectionWidget() {
  return Icon(Icons.not_interested);
}

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
    this.icon1,
    this.link1,
    this.fun1,
    this.icon2,
    this.link2,
    this.fun2,
    this.icon3,
    this.link3,
    this.fun3,
    this.underLine,
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

  final IconData icon1;
  final String link1;
  final Function fun1;

  final IconData icon2;
  final String link2;
  final Function fun2;

  final IconData icon3;
  final String link3;
  final Function fun3;

  final Color underLine;

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

          /// links
          Container(
            margin: EdgeInsets.only(left: 4.0, top: 2.0, right: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /// link1
                Row(
                  children: <Widget>[
                    Icon(
                      widget.icon1,
                      color: Colors.blueAccent,
                    ),
                    FlatButton(
                      child: Text(
                        widget.link1,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () => widget.fun1(),
                    ),
                  ],
                ),

                /// link2
                Row(
                  children: <Widget>[
                    Icon(
                      widget.icon2,
                      color: Colors.blueAccent,
                    ),
                    FlatButton(
                      child: Text(
                        widget.link2,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () => widget.fun2(),
                    ),
                  ],
                ),

                /// link3
                Row(
                  children: <Widget>[
                    Icon(
                      widget.icon3,
                      color: Colors.blueAccent,
                    ),
                    FlatButton(
                      child: Text(
                        widget.link3,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                      onPressed: () => widget.fun3(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
