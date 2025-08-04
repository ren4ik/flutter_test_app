import 'package:flutter/foundation.dart';

class LogService {
  static final List<String> _logs = [];

  static void log(String message) {
    if (kDebugMode) {
      final logEntry = "[${DateTime.now()}] $message";
      _logs.add(logEntry);
      print(logEntry);
    }
  }

  static List<String> get logs => List.unmodifiable(_logs);
}
