import 'package:flutter/material.dart';
import '../../validators/password_validator.dart';
import '../password_requirements.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String labelText;
  final bool showRequirements;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.labelText = 'Senha',
    this.showRequirements = false,
  }) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: widget.labelText,
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          onChanged: (value) {
            widget.onChanged(value);
            setState(() {}); // Atualiza os requisitos se necessário
          },
          validator: widget.validator ?? PasswordValidator.validateWithMessage,
        ),
        if (widget.showRequirements && widget.controller.text.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PasswordRequirements(password: widget.controller.text),
          ),
      ],
    );
  }
}
