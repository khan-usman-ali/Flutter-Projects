import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color textcolor;
  final Color backgroundColor;
  const DefaultButton({
    super.key,
    required this.onPressed,
    required this.textcolor,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
        textStyle: WidgetStatePropertyAll<TextStyle>(
          TextStyle(color: textcolor),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}















