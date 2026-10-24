import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const CalyxApp());
}

class CalyxApp extends StatelessWidget {
  const CalyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calyx Task',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
    );
  }
}
