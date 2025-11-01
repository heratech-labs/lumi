import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({super.key, required this.password});

  bool _hasUppercase(String s) => s.contains(RegExp(r'[A-Z]'));
  bool _hasLowercase(String s) => s.contains(RegExp(r'[a-z]'));
  bool _hasSpecialChar(String s) => s.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool _hasMinLength(String s) => s.length >= 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        Text(
          'A senha deve conter:',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        const SizedBox(height: 4),
        _buildRule('Pelo menos 8 caracteres', _hasMinLength(password)),
        _buildRule('Uma letra maiúscula', _hasUppercase(password)),
        _buildRule('Uma letra minúscula', _hasLowercase(password)),
        _buildRule('Um caractere especial', _hasSpecialChar(password)),
      ],
    );
  }

  Widget _buildRule(String text, bool valid) {
    return Row(
      children: [
        Icon(
          valid ? Icons.check_circle : Icons.cancel,
          size: 16,
          color: valid ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: valid ? Colors.green[700] : Colors.red[700],
          ),
        ),
      ],
    );
  }
}
