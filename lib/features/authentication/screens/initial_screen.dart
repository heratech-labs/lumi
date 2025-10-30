import 'package:flutter/material.dart';
import '../../../app/config/app_routes.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/buttons/secondary_button.dart';
import '../../../common/widgets/images/lumi_logo.dart';
import '../../../common/widgets/text/body_text.dart';
import '../../../common/widgets/text/screen_title.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              const LumiLogo(width: 140, height: 140),

              const SizedBox(height: 32),

              const ScreenTitle('LUMI'),

              const SizedBox(height: 16),

              const AppBodyText('Olá, que bom ter você aqui.'),

              const SizedBox(height: 16),

              const AppBodyText(
                'Lumi é feito para te acompanhar nos dias bons e difíceis. Selecione como você está se sentindo hoje e deixe a gente cuidar de você',
              ),

              const Spacer(flex: 3),

              PrimaryActionButton(
                label: 'Vamos Começar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.moodEntry);
                },
              ),

              const SizedBox(height: 16),

              SecondaryButton(
                label: 'Já tenho uma conta',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.authForm);
                },
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
