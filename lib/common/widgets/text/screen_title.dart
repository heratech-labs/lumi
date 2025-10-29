import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String text;
  final Color? color;

  const ScreenTitle(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        letterSpacing: 3.0,
        color: color ?? Colors.black87,
      ),
    );
  }
}
