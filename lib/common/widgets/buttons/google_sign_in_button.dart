import './secondary_button.dart';
import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label; // texto dinâmico

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.label = 'Entrar com Google', // valor padrão
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      label: label, // <-- usa o parâmetro, não hardcoded
      icon: Image.asset(
        'assets/images/google_logo.webp', // Caminho correto do asset
        height: 24,
      ),
      onPressed: onPressed,
    );
  }
}
