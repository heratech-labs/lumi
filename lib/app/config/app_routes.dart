import 'package:flutter/material.dart';
import '../../features/authentication/screens/initial_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/mood_tracker/screens/mood_entry_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/home/screens/register.dart';
import '../../features/home/screens/login.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String moodEntry = '/mood_entry';
  static const String profile = '/profile';
  static const String register = '/register';
  static const String login = '/login';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initial: (context) => const InitialScreen(),
      home: (context) => const HomeScreen(),
      moodEntry: (context) => const MoodEntryScreen(),
      register: (context) => const RegisterScreen(),
      login: (context) => const LoginScreen(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final routes = getRoutes();
    final builder = routes[settings.name];

    if (builder != null) {
      return MaterialPageRoute(
        builder: (context) => builder(context),
        settings: settings,
      );
    }

    return null;
  }
}
