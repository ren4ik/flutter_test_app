import 'package:flutter/material.dart';
import 'package:myid/myid.dart';

class VerificationScreen extends StatelessWidget {
  final String sessionId;
  final String clientHash;
  final String clientHashId;

  const VerificationScreen({
    super.key,
    required this.sessionId,
    required this.clientHash,
    required this.clientHashId,
  });

  Future<void> _startVerification(BuildContext context) async {
    try {
      final result = await MyIdClient.start(
        config: MyIdConfig(
          sessionId: sessionId,
          clientHash: clientHash,
          clientHashId: clientHashId,
          environment: MyIdEnvironment.TESTING,
          entryType: MyIdEntryType.IDENTIFICATION,
        ),
        iosAppearance: const MyIdIOSAppearance(), // Можно кастомизировать
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('MyID завершён: ${result.resultStatus.name}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка MyID: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Проверка клиента')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startVerification(context),
          child: const Text('Запустить MyID'),
        ),
      ),
    );
  }
}
