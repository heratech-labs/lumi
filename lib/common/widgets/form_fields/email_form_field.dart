import 'package:flutter/material.dart';

/// EmailField
/// 
/// Widget reutilizável para entrada de e-mail com validação.
/// Observações importantes:
/// - Este widget lida apenas com UI e validação do formulário.
/// - A lógica de autenticação deve ser implementada em outro arquivo/serviço,
///   por exemplo: auth_service.dart
/// - Evita misturar UI com backend, facilitando manutenção futura.
/// 
class EmailField extends StatelessWidget {
  // Controlador para acessar o valor do campo de e-mail
  final TextEditingController controller;

  // Texto de dica (placeholder) dentro do campo
  final String? hintText;

  // Callback que é chamado sempre que o valor do campo muda
  final Function(String)? onChanged;

  // FocusNode do campo atual, usado para gerenciamento de foco
  final FocusNode? focusNode;

  // FocusNode do próximo campo, permite navegar para o próximo ao apertar "next"
  final FocusNode? nextFocusNode;

  const EmailField({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Conecta o controlador ao campo
      controller: controller,

      // Tipo de teclado apropriado para e-mail
      keyboardType: TextInputType.emailAddress,

      // Define a ação do botão "Enter" no teclado
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,

      // Evita correção automática e capitalização, comuns em emails
      autocorrect: false,
      textCapitalization: TextCapitalization.none,

      // Sugere preenchimento automático de e-mail
      autofillHints: const [AutofillHints.email],

      // Foco do campo atual
      focusNode: focusNode,

      // Ao apertar "Enter", passa o foco para o próximo campo (se houver)
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        }
      },

      // Decoração do campo (borda, label, ícone, erros)
      decoration: InputDecoration(
        labelText: 'E-mail', // Label acima do campo
        hintText: hintText ?? 'exemplo@gmail.com', // Placeholder dentro do campo
        suffixIcon: const Icon(Icons.email_outlined), // Ícone à direita
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), // Borda padrão
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(57, 57, 57, 1), width: 2),
        ),
        // Estilo da mensagem de erro
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),

      // Validação do campo (executada quando _formKey.currentState!.validate() é chamado)
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu e-mail';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Insira um e-mail válido';
        }
        return null; // Campo válido
      },

      // Callback chamado a cada alteração do campo
      onChanged: onChanged,
    );
  }
}

/// ==============================================
/// Sugestões de implementação de backend (não aqui!)
/// ==============================================
/// 1. Crie um arquivo/service chamado auth_service.dart (ou similar)
///    para concentrar toda lógica de autenticação (Firebase Auth, API REST, etc.).
/// 
/// 2. A tela de Login/Cadastro deve chamar métodos do AuthService:
///    - loginWithEmail(email, password)
///    - signUpWithEmail(email, password)
///    - loginWithGoogle()
/// 
/// 3. Nunca coloque lógica de autenticação diretamente no widget!
///    Mantenha EmailField apenas para UI e validação.
/// 
/// 4. Trate os erros de autenticação no AuthService e retorne mensagens
///    amigáveis para a tela mostrar ao usuário.
/// 
/// 5. Use o GlobalKey<FormState> da tela para validar todos os campos
///    antes de chamar a função de login/cadastro.
///
/// Exemplo rápido de uso na tela de login:
/// 
/// if (_formKey.currentState!.validate()) {
///   AuthService.loginWithEmail(
///     _emailController.text,
///     _passwordController.text,
///   );
/// }
