// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../app/config/app_routes.dart';
import '../../../common/widgets/form_fields/email_form_field.dart';
import '../../../common/widgets/form_fields/password_form_field.dart';
import '../../../common/widgets/form_fields/name_form_field.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/buttons/google_sign_in_button.dart';
import '../widgets/password_requirements.dart';
import '../../../common/services/auth_service.dart';

/// Tela de Cadastro do Lumi

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String _password = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

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

                    NameField(
                      controller: _nameController,
                      onChanged: (value) {},
                      hintText: 'Digite seu nome completo',
                    ),
                    const SizedBox(height: 16),

                    const SizedBox(height: 16),

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
                      useStrictValidation:
                          true, // Validação completa para registro
                    ),
                    const SizedBox(height: 16),
                    PasswordRequirements(password: _password), //regras de senha
                    const SizedBox(height: 24),
                    // ===============================
                    // Botão de cadastro
                    // ===============================
                    PrimaryActionButton(
                      label: 'Criar conta',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final authService = AuthService();
                            await authService.registerWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text,
                              displayName: _nameController.text.trim(),
                            );
                            if (mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.moodEntry,
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        }
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
                      onPressed: () async {
                        print('GoogleSignInButton pressed (register)');
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Iniciando login com Google...')),
                          );
                        }
                        try {
                          final authService = AuthService();
                          await authService.signInWithGoogle();
                          if (mounted) {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutes.moodEntry,
                            );
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
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
