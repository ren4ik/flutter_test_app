import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/login_screen.dart';
import 'themes/ucell_theme.dart';

Future<void> main() async {
  await dotenv.load(); // Загружаем .env
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ucell App',
      theme: UcellTheme.theme,
      locale: const Locale('ru'),
      supportedLocales: const [
        Locale('ru'),
        Locale('uz'),
      ],
      home: const LoginScreen(),
    );
  }
}
