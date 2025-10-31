import 'package:flutter/material.dart';
// import 'password_validator.dart'; // Arquivo sugerido para validação centralizada

/// ------------------------------
/// Campo de Senha
/// ------------------------------
/// - Mostra/oculta a senha.
/// - Permite validação usando PasswordValidator (arquivo password_validator.dart).
/// - Pode atualizar visualmente as regras via onChanged (para PasswordRequirements).
/// - Comentários indicam onde chamar funções já implementadas (backend/Firebase)
class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final Function(String)? onChanged;
  final FocusNode? focusNode; // Para navegação entre campos
  final FocusNode? nextFocusNode;

  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Digite sua senha',
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true; // Controla se a senha é visível ou não

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      focusNode: widget.focusNode,
      onFieldSubmitted: (_) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
      },
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      autofillHints: const [AutofillHints.password],
      onChanged: widget.onChanged, // Atualiza visualmente PasswordRequirements
      // validator: PasswordValidator.validate, // Validação centralizada
      decoration: InputDecoration(
        labelText: widget.label,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(57, 57, 57, 1), width: 2),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}

/// ------------------------------
/// Sugestão de implementação do backend
/// ------------------------------
/// Exemplo de uso do PasswordField dentro de um Form:
///
/// final _passwordController = TextEditingController();
/// final _formKey = GlobalKey<FormState>();
///
/// Form(
///   key: _formKey,
///   child: Column(
///     children: [
///       PasswordField(
///         controller: _passwordController,
///         onChanged: (val) {
///           // Atualiza visualmente as regras (PasswordRequirements)
///           setState(() {});
///         },
///       ),
///       PasswordRequirements(password: _passwordController.text),
///       PrimaryActionButton(
///         label: 'Criar Conta',
///         onPressed: () async {
///           if (_formKey.currentState!.validate()) {
///             // ------------------------------
///             // Backend/Firebase
///             // ------------------------------
///             // Aqui você chama a função já implementada no AuthService
///             // para criar usuário ou logar:
///             // Exemplo para registro:
///             // final success = await AuthService.registerWithEmail(
///             //   _emailController.text,
///             //   _passwordController.text,
///             // );
///             // Exemplo para login:
///             // final success = await AuthService.loginWithEmail(
///             //   _emailController.text,
///             //   _passwordController.text,
///             // );
///             // ------------------------------
///             // Após sucesso:
///             // if (success) {
///             //   Navigator.pushNamed(context, AppRoutes.moodEntry);
///             // } else {
///             //   ScaffoldMessenger.of(context).showSnackBar(
///             //     const SnackBar(content: Text('Falha na autenticação')),
///             //   );
///             // }
///           }
///         },
///       ),
///     ],
///   ),
/// )
