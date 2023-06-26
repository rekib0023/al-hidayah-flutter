import 'package:flutter/material.dart';

import 'features/login/ui/login_screen.dart';
import 'styles/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
