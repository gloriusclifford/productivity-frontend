import 'package:flutter/material.dart';
import 'package:productivity_app_frontend/app/theme/app_theme.dart';
import 'package:productivity_app_frontend/app/main_wrapper.dart';
import 'package:productivity_app_frontend/features/auth/presentation/screens/login_screen.dart';
import 'package:productivity_app_frontend/features/auth/presentation/screens/register_screen.dart';
import 'package:productivity_app_frontend/features/splash/presentation/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanIt',
      debugShowCheckedModeBanner: false,
      theme: getPlanItTheme(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainWrapper(),
      },
    );
  }
}