import 'package:flutter/material.dart';
import '../../../app/config/app_routes.dart';
import '../../../common/widgets/layout/lumi_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Tela Home - Em desenvolvimento')),
      bottomNavigationBar: const LumiBottomNavBar(currentRoute: AppRoutes.home),
    );
  }
}
