import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/logger_service.dart';
import 'verification_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _deviceId = 'flutter-device-id'; // заменить на реальный device_id
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final url = Uri.parse('https://regblanc.ucell.uz/api/v1/dealer/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'login': _loginController.text,
          'password': _passwordController.text,
          'device_id': _deviceId,
        }),
      );

      LogService.log("Запрос на вход: ${_loginController.text}");
      LogService.log("Ответ от сервера: ${response.body}");

      setState(() => _loading = false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        LogService.log("Успешный вход. Токен: $token");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerificationScreen(
              sessionId: dotenv.env['SESSION_ID'] ?? '',
              clientHash: dotenv.env['CLIENT_HASH'] ?? '',
              clientHashId: dotenv.env['CLIENT_HASH_ID'] ?? '',
            ),
          ),
        );
      } else {
        setState(() => _error = 'Ошибка входа: ${response.statusCode}');
        LogService.log("Ошибка входа. Код: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Ошибка при логине: ${e}';
      });
      LogService.log("Исключение при логине: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Вход в систему"),
        actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.bug_report),
              onPressed: () {
                Navigator.pushNamed(context, '/logs');
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _loginController,
              decoration: const InputDecoration(labelText: 'Логин'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Пароль'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text('Войти'),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(_error!, style: const TextStyle(color: Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}
