import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogs {
  factory AppLogs() => _instance;
  AppLogs._internal();

  static final AppLogs _instance = AppLogs._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,  // Suppress method traces
      errorMethodCount: 3,  // Number of methods to show for errors
      lineLength: 80,  // Line length for log wrapping
      colors: true,  // Disable ANSI color codes
      printEmojis: true,  // Use emojis for log levels
    ),
  );

  // String _getCurrentTimestamp() {
  //   final DateTime now = DateTime.now();
  //   return '${now.hour}:${now.minute}:${now.second}.${now.millisecond}';
  // }

  void successLog(String message, {String tag = 'Success'}) {
    if (kDebugMode) {
      final logMessage = '✅  $message';
      _logger.d(logMessage);
    }
  }

  void debugLog(String message, {String tag = 'Debug'}) {
    if (kDebugMode) {
      final logMessage = '🐛️  $message';
      _logger.d(logMessage);
    }
  }


  void warningLog(String message, {String tag = 'Warning'}) {
    if (kDebugMode) {
      final logMessage = '⚠️  $message';
      _logger.w(logMessage);
    }
  }

  void errorLog(
      String message, {
        String tag = 'Error',
        Object? error,
        StackTrace? stackTrace,
      }) {
    if (kDebugMode) {
      final logMessage = '❌  $message';
      _logger.e(logMessage, error: error, stackTrace: stackTrace);
    }
  }
}
