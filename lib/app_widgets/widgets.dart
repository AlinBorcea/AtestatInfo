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
