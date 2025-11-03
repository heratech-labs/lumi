import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final String password;

  const PasswordRequirements({Key? key, required this.password})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequirement('Pelo menos 8 caracteres', password.length >= 8),
        _buildRequirement(
          'Uma letra maiúscula',
          password.contains(RegExp(r'[A-Z]')),
        ),
        _buildRequirement(
          'Uma letra minúscula',
          password.contains(RegExp(r'[a-z]')),
        ),
        _buildRequirement(
          'Um caractere especial',
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
        ),
      ],
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.circle_outlined,
            color: isMet ? Colors.green : Colors.grey,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isMet ? Colors.green : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
