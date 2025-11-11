import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class MoodService {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://lumi-7ae93-default-rtdb.firebaseio.com',
  ).ref();

  /// Salva um registro de humor do usuário
  Future<void> saveMood(String moodText) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final String userId = user.uid;
      final String timestamp = DateTime.now().toIso8601String();

      // Estrutura: /users/{userId}/moods/{timestamp}
      await _database.child('users/$userId/moods').push().set({
        'text': moodText,
        'timestamp': timestamp,
        'createdAt': ServerValue.timestamp,
      });

      print('✅ Mood salvo com sucesso!');
    } catch (e) {
      print('❌ Erro ao salvar mood: $e');
      rethrow;
    }
  }

  /// Busca o último registro de humor do usuário
  Future<String?> getLastMood() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final String userId = user.uid;

      // Busca o último registro ordenado por timestamp
      final snapshot = await _database
          .child('users/$userId/moods')
          .orderByChild('createdAt')
          .limitToLast(1)
          .get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final lastEntry = data.values.first as Map<dynamic, dynamic>;
        return lastEntry['text'] as String?;
      }

      return null;
    } catch (e) {
      print('❌ Erro ao buscar mood: $e');
      return null;
    }
  }

  /// Busca todos os registros de humor do usuário
  Future<List<Map<String, dynamic>>> getAllMoods() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final String userId = user.uid;

      final snapshot = await _database
          .child('users/$userId/moods')
          .orderByChild('createdAt')
          .get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        return data.entries
            .map((entry) => {
                  'id': entry.key,
                  ...Map<String, dynamic>.from(entry.value as Map),
                })
            .toList();
      }

      return [];
    } catch (e) {
      print('❌ Erro ao buscar todos os moods: $e');
      return [];
    }
  }

  /// Atualiza um registro de humor específico
  Future<void> updateMood(String moodId, String newText) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final String userId = user.uid;

      await _database.child('users/$userId/moods/$moodId').update({
        'text': newText,
        'updatedAt': ServerValue.timestamp,
      });

      print('✅ Mood atualizado com sucesso!');
    } catch (e) {
      print('❌ Erro ao atualizar mood: $e');
      rethrow;
    }
  }

  /// Deleta um registro de humor específico
  Future<void> deleteMood(String moodId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final String userId = user.uid;

      await _database.child('users/$userId/moods/$moodId').remove();

      print('✅ Mood deletado com sucesso!');
    } catch (e) {
      print('❌ Erro ao deletar mood: $e');
      rethrow;
    }
  }

  /// Stream para ouvir mudanças em tempo real nos moods
  Stream<List<Map<String, dynamic>>> getMoodsStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Stream.value([]);
    }

    final String userId = user.uid;

    return _database
        .child('users/$userId/moods')
        .orderByChild('createdAt')
        .onValue
        .map((event) {
      if (event.snapshot.exists) {
        final data = event.snapshot.value as Map<dynamic, dynamic>;
        return data.entries
            .map((entry) => {
                  'id': entry.key,
                  ...Map<String, dynamic>.from(entry.value as Map),
                })
            .toList();
      }
      return <Map<String, dynamic>>[];
    });
  }
}
