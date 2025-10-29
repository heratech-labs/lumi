import 'package:flutter/material.dart';

import '../../../common/services/date_formatter.dart';
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

  @override
  void initState() {
    super.initState();
    _moodController = TextEditingController();
    _todayLabel = DateFormatter.formatFullDate(DateTime.now());
  }

  @override
  void dispose() {
    _moodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const displayName = 'Pedro E.';
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
                'Como você está se sentindo hoje?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(height: 14),
              MultilineTextField(
                controller: _moodController,
                hintText: 'Lorem ipsum...',
                minLines: 5,
                maxLines: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
