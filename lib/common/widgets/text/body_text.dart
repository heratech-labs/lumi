import 'package:flutter/material.dart';

class AppBodyText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;

  const AppBodyText(this.text, {super.key, this.textAlign, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: color ?? Colors.grey[700],
      ),
    );
  }
}
