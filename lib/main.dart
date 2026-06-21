import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/features/auth/presentation/auth_state.dart';
import 'src/features/notes/presentation/notes_state.dart';
import 'src/features/auth/presentation/onboarding_screen.dart';
import 'src/features/auth/presentation/login_screen.dart';
import 'src/features/navigation/presentation/main_navigation_screen.dart';
import 'src/core/theme/neo_brutalist_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const AuthWrapper(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainNavigationScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, authState, child) {
        if (!authState.isInitialized) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: NeoBrutalism.primaryPurple,
              ),
            ),
          );
        }

        if (!authState.isOnboardingCompleted) {
          return const OnboardingScreen();
        }

        if (!authState.isLoggedIn) {
          return const LoginScreen();
        }

        return const MainNavigationScreen();
      },
    );
  }
}
