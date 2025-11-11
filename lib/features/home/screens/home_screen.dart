import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../app/config/app_routes.dart';
import '../../../common/services/date_formatter.dart';
import '../../../common/widgets/layout/lumi_bottom_nav_bar.dart';
import '../../../common/widgets/layout/welcome_header.dart';
import '../widgets/content_carousel.dart';
import '../widgets/inspiration_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o usuário autenticado
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'User';
    final firstName = displayName.split(' ').first;
    final todayLabel = DateFormatter.formatFullDate(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com saudação
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: WelcomeHeader(
                  userName: firstName,
                  dateLabel: todayLabel,
                  greeting: 'Seja Bem-vindo, $firstName',
                ),
              ),

              // Card de inspiração
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: InspirationCard(
                  message:
                      'Esta é sua área de conforto, onde você pode explorar conteúdos que cuidam do seu bem-estar emocional.',
                  imagePath: 'assets/images/daily_sugestion.png',
                ),
              ),

              const SizedBox(height: 32),

              // Título "Sugestões do dia"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sugestões do dia',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ciência da computação acaba com a pessoa. Saia disso já!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Carrossel de Músicas
              ContentCarousel(
                title: 'Músicas',
                items: const [
                  ContentItem(
                    title: 'Música Relaxante',
                    subtitle: 'Playlist Calma',
                    icon: Icons.music_note_rounded,
                  ),
                  ContentItem(
                    title: 'Sons da Natureza',
                    subtitle: 'Meditação',
                    icon: Icons.music_note_rounded,
                  ),
                  ContentItem(
                    title: 'Piano Suave',
                    subtitle: 'Concentração',
                    icon: Icons.music_note_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Carrossel de Filmes
              ContentCarousel(
                title: 'Filmes',
                items: const [
                  ContentItem(
                    title: 'Filme Motivacional',
                    subtitle: 'Drama',
                    icon: Icons.movie_rounded,
                  ),
                  ContentItem(
                    title: 'Comédia Leve',
                    subtitle: 'Comédia',
                    icon: Icons.movie_rounded,
                  ),
                  ContentItem(
                    title: 'Documentário',
                    subtitle: 'Natureza',
                    icon: Icons.movie_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Carrossel de Livros
              ContentCarousel(
                title: 'Livros',
                items: const [
                  ContentItem(
                    title: 'Mindfulness',
                    subtitle: 'Autoajuda',
                    icon: Icons.book_rounded,
                  ),
                  ContentItem(
                    title: 'O Poder do Agora',
                    subtitle: 'Espiritualidade',
                    icon: Icons.book_rounded,
                  ),
                  ContentItem(
                    title: 'Inteligência Emocional',
                    subtitle: 'Psicologia',
                    icon: Icons.book_rounded,
                  ),
                ],
              ),

              const SizedBox(height: 100), // Espaço para a bottom nav bar
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LumiBottomNavBar(currentRoute: AppRoutes.home),
    );
  }
}
