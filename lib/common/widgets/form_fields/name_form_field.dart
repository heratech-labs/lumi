import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final String hintText;

  const NameField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.validator,
    this.hintText = 'Digite seu nome', 
  });

  static bool isValidName(String name) {
    // Aceita letras, acentos e espaços
    return RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ]+(?: [A-Za-zÀ-ÖØ-öø-ÿ]+)*$")
        .hasMatch(name);
  }

  @override
 @override
Widget build(BuildContext context) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: 'Nome',
      hintText: hintText,
      suffixIcon: const Icon(Icons.person),
    ),
    textCapitalization: TextCapitalization.words,
    keyboardType: TextInputType.name,
    textInputAction: TextInputAction.next,
    autofillHints: const [AutofillHints.name],
    onChanged: onChanged,
    validator: validator ??
        (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu nome';
          }
          if (value.trim().split(' ').length < 2) {
            return 'Por favor, insira seu nome completo';
          }
          if (!isValidName(value)) {
            return 'Nome inválido. Use apenas letras e espaços';
          }
          return null;
        },
  );
}

}
