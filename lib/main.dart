import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/features/auth/presentation/auth_state.dart';
import 'src/features/notes/presentation/notes_state.dart';
import 'src/features/auth/presentation/onboarding_screen.dart';
import 'src/features/auth/presentation/login_screen.dart';
import 'src/features/navigation/presentation/main_navigation_screen.dart';
import 'src/core/theme/neo_brutalist_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthState()),
        ChangeNotifierProvider(create: (context) => NotesState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STUDYBRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: NeoBrutalism.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: NeoBrutalism.primaryPurple,
          primary: NeoBrutalism.primaryPurple,
          surface: NeoBrutalism.background,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Courier', color: NeoBrutalism.darkBlack),
          bodyMedium: TextStyle(fontFamily: 'Courier', color: NeoBrutalism.darkBlack),
        ),
      ),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainNavigationScreen(),
      },
    );
  }
}
