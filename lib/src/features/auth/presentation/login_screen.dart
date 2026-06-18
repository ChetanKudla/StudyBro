import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/neo_brutalist_theme.dart';
import 'auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: NeoBrutalism.accentOrange,
              border: Border.all(color: NeoBrutalism.darkBlack, width: 2),
            ),
            child: const Text(
              'Please enter both email and password!',
              style: TextStyle(color: NeoBrutalism.darkBlack, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
      return;
    }

    // Set logged in and proceed
    Provider.of<AuthState>(context, listen: false).setLogin(true);
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _handleSkip() {
    // Skip login and proceed directly
    Provider.of<AuthState>(context, listen: false).setLogin(false);
    Navigator.of(context).pushReplacementNamed('/main');
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: NeoBrutalism.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40.0),
                const Text(
                  'WELCOME\nSTUDENT!',
                  style: TextStyle(
                    fontSize: 42.0,
                    fontWeight: FontWeight.w900,
                    height: 1.0,
                    color: NeoBrutalism.darkBlack,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Hey ${authState.studentName}! Set up an optional account or skip to browse notes instantly.',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40.0),
                
                // Form Inputs
                BrutalTextField(
                  controller: _emailController,
                  labelText: 'EMAIL ADDRESS',
                  hintText: 'e.g. name@university.edu',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 20.0),
                BrutalTextField(
                  controller: _passwordController,
                  labelText: 'PASSWORD',
                  hintText: '••••••••',
                  prefixIcon: Icons.lock_outline,
                ),
                const SizedBox(height: 32.0),
                
                // Login Button
                BrutalButton(
                  backgroundColor: NeoBrutalism.primaryPurple,
                  onPressed: _handleLogin,
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          color: NeoBrutalism.pureWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                
                // Skip Button (Neo Brutalist Styling - white background, black border)
                GestureDetector(
                  onTap: _handleSkip,
                  child: BrutalContainer(
                    backgroundColor: NeoBrutalism.pureWhite,
                    padding: 12.0,
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'SKIP FOR NOW →',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            color: NeoBrutalism.darkBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
