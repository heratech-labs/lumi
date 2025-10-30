import 'package:flutter/material.dart';

class LumiLogo extends StatelessWidget {
  final double? width;
  final double? height;

  const LumiLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/lumi_logo.png',
      width: width ?? 120,
      height: height ?? 120,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width ?? 120,
          height: height ?? 120,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.lightbulb_outline,
            size: (width ?? 120) * 0.6,
            color: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
