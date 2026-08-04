import 'package:flutter/material.dart';
import '../models/user_store.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      final success = UserStore.instance.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (success) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
              const SizedBox(height: 32),
              Semantics(
                identifier: 'login_email_field',
                label: 'login_email_field',
                textField: true,
                child: TextFormField(
                  key: const Key('loginEmailField'),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your email';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Semantics(
                identifier: 'login_password_field',
                label: 'login_password_field',
                textField: true,
                child: TextFormField(
                  key: const Key('loginPasswordField'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your password';
                    return null;
                  },
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Semantics(
                  identifier: 'login_error_message',
                  label: 'login_error_message',
                  child: Text(
                    key: const Key('loginErrorMessage'),
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Semantics(
                identifier: 'login_button',
                label: 'login_button',
                button: true,
                child: ElevatedButton(
                  key: const Key('loginButton'),
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}