import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const EmailField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: onChanged,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um email';
            }
            if (!isValidEmail(value)) {
              return 'Por favor, insira um email válido';
            }
            return null;
          },
    );
  }
}
