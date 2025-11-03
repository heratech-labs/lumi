import 'package:flutter/material.dart';

class PasswordValidator {
  static bool validate(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  static String? validateWithMessage(String? password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, insira uma senha';
    }

    if (password.length < 8) {
      return 'A senha deve ter pelo menos 8 caracteres';
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'A senha deve conter pelo menos uma letra maiúscula';
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'A senha deve conter pelo menos uma letra minúscula';
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'A senha deve conter pelo menos um caractere especial';
    }

    return null;
  }
}
