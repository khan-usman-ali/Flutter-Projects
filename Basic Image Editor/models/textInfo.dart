import 'package:flutter/material.dart';

class Textinfo {
  String text;
  double left;
  double top;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  double fontsize;
  TextAlign textAlign;

  Textinfo({
    required this.text,
    required this.left,
    required this.top,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontsize,
    required this.textAlign,
  });
}
