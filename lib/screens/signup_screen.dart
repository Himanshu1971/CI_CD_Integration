import 'package:flutter/material.dart';
import '../models/user_store.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      UserStore.instance.signUp(
        _emailController.text.trim(),
        _passwordController.text,
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_add_alt, size: 80, color: Colors.blue),
              const SizedBox(height: 32),
              Semantics(
                identifier: 'signup_email_field',
                label: 'signup_email_field',
                textField: true,
                child: TextFormField(
                  key: const Key('signupEmailField'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your email';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                identifier: 'signup_password_field',
                label: 'signup_password_field',
                textField: true,
                child: TextFormField(
                  key: const Key('signupPasswordField'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter a password';
                    if (value.length < 6) return 'Minimum 6 characters';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              Semantics(
                identifier: 'signup_button',
                label: 'signup_button',
                button: true,
                child: ElevatedButton(
                  key: const Key('signupButton'),
                  onPressed: _handleSignup,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                key: const Key('goToLoginLink'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}