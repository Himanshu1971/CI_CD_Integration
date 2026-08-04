import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'screens/signup_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Practice App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SignupScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}