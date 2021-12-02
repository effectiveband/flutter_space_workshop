import 'dart:math';

import 'package:flutter/material.dart';

class PlaceholderCardTall extends StatelessWidget {
  final double width;
  final double height;
  final double cornerRadius;
  final Color color;
  final Color backgroundColor;

  const PlaceholderCardTall(
      {Key? key,
      this.cornerRadius = 4,
      this.color = const Color(0xfff2f2f2),
      this.backgroundColor = Colors.white,
      this.width = 400,
      this.height = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var r = Random();
    var fgColor = color;
    double lineHeight = 14;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999), color: fgColor),
            height: 45,
            width: 45,
          ),
          Container(
              margin: const EdgeInsets.only(left: 65, top: 10),
              color: fgColor,
              height: lineHeight * 1.2,
              width: 100.0 + r.nextInt(100)),
          Container(
              margin: EdgeInsets.only(top: 60, right: 10.0 + r.nextInt(60)),
              color: fgColor,
              height: lineHeight),
          Container(
              margin: EdgeInsets.only(top: 85, right: 10.0 + r.nextInt(60)),
              color: fgColor,
              height: lineHeight),
          Container(
              margin: EdgeInsets.only(top: 110, right: 10.0 + r.nextInt(60)),
              color: fgColor,
              height: lineHeight),
          Container(
              margin: EdgeInsets.only(top: 135, right: 60.0 + r.nextInt(60)),
              color: fgColor,
              height: lineHeight),
        ],
      ),
    );
  }
}
