import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app/config/app_routes.dart';
import '../../../common/services/date_formatter.dart';
import '../../../common/services/mood_service.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/form_fields/multiline_text_field.dart';
import '../../../common/widgets/layout/welcome_header.dart';
import '../../../common/widgets/text/screen_title.dart';

class MoodEntryScreen extends StatefulWidget {
  const MoodEntryScreen({super.key});

  @override
  State<MoodEntryScreen> createState() => _MoodEntryScreenState();
}

class _MoodEntryScreenState extends State<MoodEntryScreen> {
  late final TextEditingController _moodController;
  late final String _todayLabel;
  bool _isButtonEnabled = false;
  bool _isSaving = false;
  final MoodService _moodService = MoodService();

  @override
  void initState() {
    super.initState();
    _moodController = TextEditingController();
    _moodController.addListener(_updateButtonState);
    _todayLabel = DateFormatter.formatFullDate(DateTime.now());
  }

  void _updateButtonState() {
    final isEnabled = _moodController.text.trim().isNotEmpty;
    if (isEnabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isEnabled;
      });
    }
  }

  Future<void> _saveMood() async {
    final moodText = _moodController.text.trim();
    if (moodText.isEmpty) return;

    setState(() => _isSaving = true);

    try {
      await _moodService.saveMood(moodText);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro salvo com sucesso! 💚'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  void dispose() {
    _moodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtendo o usuário autenticado do Firebase
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'Usuário';
    final firstName = displayName.split(' ').first;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ScreenTitle(
                  displayName.toUpperCase(),
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'How do you feel today?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 32),
              WelcomeHeader(userName: firstName, dateLabel: _todayLabel),
              const SizedBox(height: 32),
              Text(
                'Ce tem problema?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade900,
                    ),
              ),
              const SizedBox(height: 14),
              MultilineTextField(
                controller: _moodController,
                hintText: 'Digite aqui...',
                minLines: 5,
                maxLines: 8,
              ),
              const SizedBox(height: 24),
              PrimaryActionButton(
                label: _isSaving ? 'Salvando...' : 'Continuar',
                onPressed: _isButtonEnabled && !_isSaving ? _saveMood : () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
