import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'app/config/app_routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print('Iniciando configuração do Firebase...');

    final options = DefaultFirebaseOptions.currentPlatform;

    print('Opções do Firebase: $options');

    await Firebase.initializeApp(options: options);

    print('Firebase inicializado com sucesso!');

    final auth = FirebaseAuth.instance;

    print('Auth state: ${auth.currentUser}');
  } catch (e, stackTrace) {
    print('Erro ao inicializar Firebase: $e');

    print('Stack trace: $stackTrace');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: const Color(0xFFFFD24C),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.getRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
