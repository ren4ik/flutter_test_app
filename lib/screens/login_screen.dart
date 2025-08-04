import 'package:flutter/material.dart';
import 'verification_screen.dart'; // убедись, что путь корректный

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // Примерные тестовые данные для передачи
  final String sessionId = 'TEST_SESSION_ID';
  final String clientHash = 'TEST_CLIENT_HASH';
  final String clientHashId = 'TEST_HASH_ID';

  void _authenticate() {
    // Здесь можно добавить свою логику аутентификации

    // Переход на экран верификации MyID
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => VerificationScreen(
          sessionId: sessionId,
          clientHash: clientHash,
          clientHashId: clientHashId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ucell Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Login'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}
