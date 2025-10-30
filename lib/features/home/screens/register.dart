import 'package:flutter/material.dart';
import '../../../common/widgets/form_fields/email_form_field.dart';
import '../../../common/widgets/form_fields/password_form_field.dart';
import '../widgets/password_requirements.dart';

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
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              // Limita a largura para que não fique enorme em telas largas
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Texto de introdução
                    const Text(
                      'Você chegou até aqui!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(57,57,57,1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Estamos quase finalizando. Nessa etapa, crie sua conta para salvar suas respostas com segurança e receber um suporte ainda mais acolhedor.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(57,57,57,1),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Campo de e-mail
                    EmailField(
                      controller: _emailController,
                      hintText: 'Digite seu e-mail',
                    ),
                    const SizedBox(height: 16),

                    // Campo de senha
                    PasswordField(
                      controller: _passwordController,
                      onChanged: (val) => setState(() => _password = val),
                    ),
                    const SizedBox(height: 10),

                    // Regras de senha
                    PasswordRequirements(password: _password),
                    const SizedBox(height: 30),

                    // Botão de cadastro
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('Email: ${_emailController.text}');
                          }
                        },
                        child: const Text('Criar conta'),
                      ),
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
