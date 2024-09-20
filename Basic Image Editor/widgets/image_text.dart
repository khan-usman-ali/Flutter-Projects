import 'package:flutter/material.dart';
import 'package:image_editor/models/textInfo.dart';

class ImageText extends StatelessWidget {
  final Textinfo text;
  const ImageText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.text,
      textAlign: text.textAlign,
      style: TextStyle(
        fontWeight: text.fontWeight,
        fontStyle: text.fontStyle,
        fontSize: text.fontsize,
        color:text.color,
      ),
    );
  }
}

















