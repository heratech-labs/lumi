import 'package:flutter/material.dart';
import '../../../app/config/app_routes.dart';
import '../../../common/widgets/layout/lumi_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Center(child: Text('Tela de Perfil - Em desenvolvimento')),
      bottomNavigationBar: const LumiBottomNavBar(
        currentRoute: AppRoutes.profile,
      ),
    );
  }
}
