import 'package:flutter/material.dart';
import '../services/log_service.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = LogService.logs;

    return Scaffold(
      appBar: AppBar(title: const Text('Debug Logs')),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(logs[index]),
          );
        },
      ),
    );
  }
}
