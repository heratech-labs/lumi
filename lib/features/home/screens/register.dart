import 'package:flutter/material.dart';
import '../../../common/widgets/form_fields/email_form_field.dart';
import '../../../common/widgets/form_fields/password_form_field.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/buttons/google_sign_in_button.dart';
import '../widgets/password_requirements.dart';

/// Tela de Cadastro do Lumi
///
/// **Pendências para implementação / integração com AuthService:**
/// - Botão "Criar conta": chamar função já implementada `AuthService.registerWithEmail(...)`.
///     - Validar formulário (_formKey.currentState!.validate())
///     - Passar email e senha para a função
///     - Tratar erros retornados (ex.: senha fraca, e-mail já cadastrado)
///     - Redirecionar para tela principal após sucesso
/// - Botão "Continuar com Google": chamar função já implementada `AuthService.signInWithGoogle()`.
/// - Mensagens de erro e feedback visual podem ser exibidos com SnackBar ou dialog
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                    const Text(
                      'Vamos começar sua jornada no Lumi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(57, 57, 57, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Crie sua conta para que possamos acompanhar você de perto, registrar suas experiências e oferecer apoio sempre que precisar. Aqui, suas ideias e sentimentos são protegidos e valorizados.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(57, 57, 57, 1),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // ===============================
                    // Campo de E-mail
                    // ===============================
                    EmailField(
                      controller: _emailController,
                      hintText: 'Digite seu e-mail',
                    ),
                    const SizedBox(height: 16),

                    // ===============================
                    // Campo de Senha
                    // ===============================
                    PasswordField(
                      controller: _passwordController,
                      onChanged: (val) => setState(() => _password = val),
                    ),
                    const SizedBox(height: 16),
                    PasswordRequirements(password: _password), //regras de senha
                    const SizedBox(height: 24),
                    // ===============================
                    // Botão de cadastro
                    // ===============================
                    PrimaryActionButton(
                      label: 'Criar conta',
                      onPressed: () {
                        // --- Aqui chamar função já implementada ---
                        // AuthService.registerWithEmail(email: ..., password: ...)
                        // NÃO implementar lógica manual de cadastro aqui
                        debugPrint(
                          'Botão Criar Conta clicado - chamar AuthService.registerWithEmail',
                        );
                      },
                    ),

                    // ===============================
                    // Separador / "ou continue com Google"
                    // ===============================
                    const SizedBox(height: 16),
                    const Text(
                      'Ou',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),

                    // ===============================
                    // Botão Google
                    // ===============================
                    GoogleSignInButton(
                      label: 'Continuar com o Google',
                      onPressed: () {
                        // --- Aqui chamar função já implementada ---
                        // AuthService.signInWithGoogle()
                        debugPrint(
                          'Login com Google clicado - chamar AuthService.signInWithGoogle',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
