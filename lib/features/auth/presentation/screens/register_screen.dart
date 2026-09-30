import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: PlanItColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: PlanItColors.foreground,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: PlanItColors.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.eco_outlined,
                        size: 22,
                        color: PlanItColors.secondaryForeground,
                      ),
                    ),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: PlanItColors.foreground,
                          fontSize: 24,
                        ),
                        children: const [
                          TextSpan(text: 'PlanIt'),
                          TextSpan(
                            text: '.',
                            style: TextStyle(color: PlanItColors.sage),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  'Create Account',
                  style: theme.textTheme.displayMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Start your daily rhythm and mindfulness today',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: PlanItColors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 36),

                // Field Full Name
                TextField(
                  controller: _nameController,
                  style: theme.textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Alex Rivera',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: 16),

                // Field Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: theme.textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'hello@planit.com',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),

                // Field Password
                TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordObscured,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordObscured = !_isPasswordObscured;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Action Button Register
                ElevatedButton(
                  onPressed: () {
                    // Navigasi dummy sementara ke MainWrapper jika ingin tes flow UI
                    // Navigator.pushReplacementNamed(context, '/main');
                  },
                  child: const Text('Register'),
                ),
                const SizedBox(height: 24),

                // Footer Link Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: PlanItColors.mutedForeground,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: PlanItColors.sage,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}