import 'package:flutter/material.dart';
import '../../../common/widgets/form_fields/email_form_field.dart';
import '../../../common/widgets/form_fields/password_form_field.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/buttons/google_sign_in_button.dart';

/// Tela de Login do Lumi
///
/// Observações gerais:
/// - Esta tela lida apenas com UI, validação local e navegação.
/// - Toda lógica de autenticação deve ser implementada em AuthService.dart
///   ou outro serviço separado.
/// - É responsabilidade do backend retornar sucesso/falha e mensagens específicas.
///
/// Pendências para implementação:
/// - Chamar `AuthService.signInWithEmail(email, password)` ao clicar em "Entrar".
/// - Chamar `AuthService.signInWithGoogle()` ao clicar em "Continuar com Google".
/// - Exibir mensagens de erro específicas (email ou senha incorretos).
/// - Redirecionar para a tela principal (mood_entry_screen) após login bem-sucedido.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Chave do formulário
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      resizeToAvoidBottomInset: true, // Evita overflow com teclado
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ===============================
                  // Texto introdutório
                  // ===============================
                  Text(
                    'Que bom te ver novamente!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Que bom ter você de volta! Estamos felizes por continuar cuidando das suas experiências e oferecendo apoio quando precisar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),

                  // ===============================
                  // Campo de E-mail
                  // ===============================
                  EmailField(
                    controller: _emailController,
                    hintText: 'seuemail@gmail.com',
                  ),
                  const SizedBox(height: 16),

                  // ===============================
                  // Campo de Senha
                  // ===============================
                  PasswordField(
                    controller: _passwordController,
                    onChanged: (val) => setState(() => _password = val),
                  ),
                  const SizedBox(height: 24),

                  // ===============================
                  // Botão de Login (Email + Senha)
                  // ===============================
                  PrimaryActionButton(
                    label: 'Entrar',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // --- Aqui chamar função já implementada ---
                        // Exemplo:
                        // final success = await AuthService.signInWithEmail(
                        //   _emailController.text,
                        //   _passwordController.text,
                        // );
                        // if (success) {
                        //   Navigator.pushNamed(context, AppRoutes.moodEntry);
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Email ou senha incorretos')),
                        //   );
                        // }

                        debugPrint(
                          'Botão Entrar clicado - backend deve implementar login com email e senha',
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // ===============================
                  // Texto "ou" centralizado
                  // ===============================
                  const Text(
                    'Ou',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // ===============================
                  // Botão de Login com Google
                  // ===============================
                  GoogleSignInButton(
                    onPressed: () async {
                      // --- Aqui chamar função já implementada ---
                      // Exemplo:
                      // final success = await AuthService.signInWithGoogle();
                      // if (success) {
                      //   Navigator.pushNamed(context, AppRoutes.moodEntry);
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Falha no login com Google')),
                      //   );
                      // }

                      debugPrint(
                        'Login com Google clicado - backend deve implementar',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
