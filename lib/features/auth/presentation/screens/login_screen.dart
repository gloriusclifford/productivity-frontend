import 'package:flutter/material.dart';
import '../../../../app/theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: PlanItColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // Memaksa tinggi konten minimal setinggi layar
                  minHeight: constraints.maxHeight - 48.0, // 48 = total vertical padding (24 * 2)
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center, // Ini yang bikin posisinya center vertikal
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
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          style: theme.textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: PlanItColors.foreground,
                            fontSize: 28,
                          ),
                          children: const [
                            TextSpan(text: 'Login'),
                            TextSpan(
                              text: '.',
                              style: TextStyle(color: PlanItColors.sage),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A new day. A little room to grow.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: PlanItColors.mutedForeground,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Email Field
                      Text(
                        'Email address',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: PlanItColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'email address',
                          hintStyle: TextStyle(color: PlanItColors.mutedForeground),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          fillColor: PlanItColors.card,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: PlanItColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: PlanItColors.border),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      Text(
                        'Password',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: PlanItColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: theme.textTheme.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'At least 6 characters',
                          hintStyle: TextStyle(color: PlanItColors.mutedForeground.withOpacity(0.6)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          fillColor: PlanItColors.card,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: PlanItColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: PlanItColors.border),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot password?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: PlanItColors.sage,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PlanItColors.yellow,
                            foregroundColor: PlanItColors.foreground,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/main');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward_rounded, size: 18),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Register Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New to PlanIt? ',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: PlanItColors.mutedForeground,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                'Create an account',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: PlanItColors.foreground,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Privacy Policy',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: PlanItColors.mutedForeground.withOpacity(0.7),
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '© ${DateTime.now().year} PlanIt. All rights reserved',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: PlanItColors.mutedForeground.withOpacity(0.7),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}