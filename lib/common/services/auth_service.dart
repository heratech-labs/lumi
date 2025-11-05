// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],

//     clientId:
//         '731654279937-mi0u42q61rd776h0gb8nldq3oecm4g6r.apps.googleusercontent.com', // Opcional: pode ser definido aqui também
//   );

//   // Stream para monitorar mudanças no estado de autenticação

//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   // Registro com email e senha

//   Future<UserCredential> registerWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       print('Iniciando registro de usuário...');

//       print('Firebase Auth instance: ${_auth.hashCode}');

//       print('Tentando criar usuário com email: $email');

//       // Verificar estado atual do Firebase

//       print('Usuário atual: ${_auth.currentUser}');

//       print(
//         'Auth state changes listener ativo: ${_auth.authStateChanges().isBroadcast}',
//       );

//       final result = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       print('Usuário criado com sucesso: ${result.user?.uid}');

//       return result;
//     } on FirebaseAuthException catch (e) {
//       print('Erro no Firebase Auth: ${e.code} - ${e.message}');

//       print('Stack trace: ${StackTrace.current}');

//       throw _handleAuthException(e);
//     } catch (e) {
//       print('Erro não esperado: $e');

//       print('Stack trace: ${StackTrace.current}');

//       rethrow;
//     }
//   }

//   // Login com email e senha

//   Future<UserCredential> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       print('Tentando fazer login com email: $email');

//       final result = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       print('Login realizado com sucesso: ${result.user?.uid}');

//       return result;
//     } on FirebaseAuthException catch (e) {
//       print('Erro no Firebase Auth: ${e.code} - ${e.message}');

//       throw _handleAuthException(e);
//     }
//   }

//   // Login com Google

//   Future<UserCredential> signInWithGoogle() async {
//     try {
//       print('Iniciando login com Google...');
//       // On web, prefer the Firebase popup flow which opens a browser popup
//       // and returns the UserCredential directly. On mobile, use the
//       // GoogleSignIn plugin flow which obtains tokens and signs in with
//       // credentials.
//       if (kIsWeb) {
//         print('Usando signInWithPopup para web');
//         final provider = GoogleAuthProvider();
//         final UserCredential result = await _auth.signInWithPopup(provider);
//         print('Login com Google (web) realizado: ${result.user?.uid}');
//         return result;
//       }

//       // Mobile / non-web flow using google_sign_in plugin
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//       // If the user cancels the sign-in, throw a friendly message
//       if (googleUser == null) {
//         throw 'Login com Google cancelado pelo usuário';
//       }

//       print('Usuário Google selecionado: ${googleUser.email}');

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final UserCredential userCredential =
//           await _auth.signInWithCredential(credential);

//       print(
//           'Login com Google realizado com sucesso: ${userCredential.user?.uid}');

//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       print('Erro no Firebase Auth: ${e.code} - ${e.message}');

//       print('Stack trace: ${StackTrace.current}');

//       throw _handleAuthException(e);
//     } catch (e) {
//       print('Erro no login com Google: $e');

//       print('Stack trace: ${StackTrace.current}');

//       throw 'Erro ao fazer login com Google: $e';
//     }
//   }

//   // Logout

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Recuperação de senha

//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw _handleAuthException(e);
//     }
//   }

//   // Tratamento de exceções do Firebase Auth

//   String _handleAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'weak-password':
//         return 'A senha fornecida é muito fraca.';

//       case 'email-already-in-use':
//         return 'Já existe uma conta com este email.';

//       case 'invalid-email':
//         return 'O email fornecido é inválido.';

//       case 'user-disabled':
//         return 'Esta conta foi desativada.';

//       case 'user-not-found':
//         return 'Não existe usuário com este email.';

//       case 'wrong-password':
//         return 'Senha incorreta.';

//       case 'too-many-requests':
//         return 'Muitas tentativas. Tente novamente mais tarde.';

//       default:
//         return 'Ocorreu um erro na autenticação: ${e.message}';
//     }
//   }
// }
