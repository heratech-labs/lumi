import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // A API do `google_sign_in` passou a expor um singleton `GoogleSignIn.instance`
  // e um método `initialize`. Vamos usar um flag para inicializar apenas uma vez.
  static bool _googleInitialized = false;

  // Stream para monitorar mudanças no estado de autenticação

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Registro com email e senha

  Future<UserCredential> registerWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      print('Iniciando registro de usuário...');

      print('Firebase Auth instance: ${_auth.hashCode}');

      print('Tentando criar usuário com email: $email');

      // Verificar estado atual do Firebase

      print('Usuário atual: ${_auth.currentUser}');

      print(
        'Auth state changes listener ativo: ${_auth.authStateChanges().isBroadcast}',
      );

      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Se foi fornecido um displayName, atualiza o perfil do usuário
      if (displayName != null && displayName.isNotEmpty) {
        try {
          await result.user?.updateDisplayName(displayName);
          // Recarrega o usuário para garantir que as mudanças sejam visíveis
          await result.user?.reload();
        } catch (e) {
          // Falha ao atualizar displayName não deve impedir o registro
          print('Falha ao atualizar displayName: $e');
        }
      }

      print('Usuário criado com sucesso: ${result.user?.uid}');

      return result;
    } on FirebaseAuthException catch (e) {
      print('Erro no Firebase Auth: ${e.code} - ${e.message}');

      print('Stack trace: ${StackTrace.current}');

      throw _handleAuthException(e);
    } catch (e) {
      print('Erro não esperado: $e');

      print('Stack trace: ${StackTrace.current}');

      rethrow;
    }
  }

  // Login com email e senha

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      print('Tentando fazer login com email: $email');

      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Login realizado com sucesso: ${result.user?.uid}');

      return result;
    } on FirebaseAuthException catch (e) {
      print('Erro no Firebase Auth: ${e.code} - ${e.message}');

      throw _handleAuthException(e);
    }
  }

  // Login com Google

  Future<UserCredential> signInWithGoogle() async {
    try {
      print('Iniciando login com Google...');

      if (kIsWeb) {
        print('Usando signInWithPopup para web');
        final provider = GoogleAuthProvider();
        final UserCredential result = await _auth.signInWithPopup(provider);
        print('Login com Google (web) realizado: ${result.user?.uid}');
        return result;
      }

      // Mobile / non-web flow using google_sign_in plugin
      // Initialize the GoogleSignIn singleton once, if necessary.
      // No clientId for Android - it comes from google-services.json automatically
      if (!_googleInitialized) {
        try {
          print('Inicializando Google Sign-In para mobile...');
          await GoogleSignIn.instance.initialize(
            // Para web, podemos passar clientId aqui se necessário
            // Para Android/iOS, o clientId vem do google-services.json
            clientId: kIsWeb
                ? '731654279937-mi0u42q61rd776h0gb8nldq3oecm4g6r.apps.googleusercontent.com'
                : null,
          );
          print('Google Sign-In inicializado com sucesso');
        } catch (e) {
          print(
              'Erro ao inicializar Google Sign-In (pode já estar inicializado): $e');
        }
        _googleInitialized = true;
      }

      print('Chamando authenticate...');
      // Trigger interactive authentication
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate(scopeHint: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ]);

      print('Usuário Google selecionado: ${googleUser.email}');

      // The new API exposes an authentication object with an idToken. Use it
      // to create Firebase credential.
      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw 'Não foi possível obter o token de autenticação do Google';
      }

      print('Token obtido, criando credencial Firebase...');
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      print('Fazendo login no Firebase com credencial Google...');
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print(
          'Login com Google realizado com sucesso: ${userCredential.user?.uid}');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Erro no Firebase Auth: ${e.code} - ${e.message}');
      print('Stack trace: ${StackTrace.current}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Erro no login com Google: $e');
      print('Tipo do erro: ${e.runtimeType}');
      print('Stack trace: ${StackTrace.current}');

      // Tratamento específico para erros do Google Sign-In
      final errorString = e.toString();
      if (errorString.contains('canceled') ||
          errorString.contains('cancelled')) {
        throw 'Login cancelado pelo usuário';
      } else if (errorString.contains('reauth failed') ||
          errorString.contains('Account reauth failed')) {
        throw 'Falha na autenticação. Verifique:\n1. Se o app está configurado no Firebase Console\n2. Se o SHA-1 foi adicionado no Firebase\n3. Se o Google Sign-In está habilitado';
      } else if (errorString.contains('DEVELOPER_ERROR') ||
          errorString.contains('10')) {
        throw 'Erro de configuração do desenvolvedor. Verifique o SHA-1 no Firebase Console';
      }
      throw 'Erro ao fazer login com Google: $e';
    }
  }

  // Logout

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Recuperação de senha

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Tratamento de exceções do Firebase Auth

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'A senha fornecida é muito fraca.';

      case 'email-already-in-use':
        return 'Já existe uma conta com este email.';

      case 'invalid-email':
        return 'O email fornecido é inválido.';

      case 'user-disabled':
        return 'Esta conta foi desativada.';

      case 'user-not-found':
        return 'Não existe usuário com este email.';

      case 'wrong-password':
        return 'Senha incorreta.';

      case 'too-many-requests':
        return 'Muitas tentativas. Tente novamente mais tarde.';

      default:
        return 'Ocorreu um erro na autenticação: ${e.message}';
    }
  }
}
