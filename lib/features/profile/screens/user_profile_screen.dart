import 'package:flutter/material.dart';
import '../../../common/widgets/buttons/primary_action_button.dart';
import '../../../common/widgets/buttons/secondary_button.dart';
import '../../../common/widgets/images/lumi_logo.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header com ícone e título
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF5F5F5),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    child: const LumiLogo(width: 32),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Luccas Adelino Jordao Garcia',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Usuário com autismo',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Conteúdo principal
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // Foto de perfil
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFDB931),
                          width: 3,
                        ),
                        color: const Color(0xFFF5F5F5),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/profile_photo.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 60,
                              color: Color(0xFFCCCCCC),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Informações do usuário
                    _buildInfoItem('Nome:', 'Luccas Adelino Jordao Garcia'),
                    const SizedBox(height: 20),
                    _buildInfoItem('Email:', 'luccas@gmail.com.br'),
                    const SizedBox(height: 20),
                    _buildInfoItem('Idade:', '24 anos'),
                    const SizedBox(height: 20),
                    _buildInfoItem(
                      'Endereço:',
                      'Morro Agudo - Miguel Fiat Cosq',
                    ),
                    const SizedBox(height: 20),
                    _buildInfoItem(
                      'Contato de emergência:',
                      '(16) 99260-7279 - Sarah Beltrigo',
                    ),

                    const SizedBox(height: 40),

                    // Botões de ação
                    PrimaryActionButton(
                      label: 'Editar Perfil',
                      onPressed: () {
                        // Navegar para tela de edição
                      },
                    ),

                    const SizedBox(height: 16),

                    SecondaryButton(
                      label: 'Sair',
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Botão S.O.S flutuante (posicionado acima da barra)
            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _showSOSDialog(context);
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFF6B9D),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'S.O.S',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'TOQUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFFFDB931),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              isActive: false,
              onTap: () {
                // Navegar para Home
              },
            ),
            const SizedBox(width: 80), // Espaço para o botão S.O.S
            _buildNavItem(
              icon: Icons.person,
              label: 'Perfil',
              isActive: true,
              onTap: () {
                // Já está na tela de perfil
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF333333) : Colors.white,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? const Color(0xFF333333) : Colors.white,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'S.O.S - Emergência',
          style: TextStyle(
            color: Color(0xFFFF6B9D),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deseja acionar o contato de emergência?',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Sarah Beltrigo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '(16) 99260-7279',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xFF666666), fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implementar lógica de chamada de emergência
              // Por exemplo: url_launcher para fazer ligação
              // launchUrl(Uri.parse('tel:16992607279'));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B9D),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Ligar Agora',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sair',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: const Text(
          'Tem certeza que deseja sair da sua conta?',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Color(0xFF666666), fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implementar lógica de logout
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFDB931),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Sair',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
