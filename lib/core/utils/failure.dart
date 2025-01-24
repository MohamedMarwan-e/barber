import 'dart:convert';

import 'package:dio/dio.dart';

class Failure {
  const Failure({
    required this.message,
    this.statusCode,
    this.details,
  });

  final String message;
  final int? statusCode;
  final dynamic details; // Can now store a map or string

  @override
  String toString() {
    return 'Failure(message: $message, statusCode: $statusCode, details: $details)';
  }

  static Failure fromDioError(DioException e) {
    dynamic parsedDetails = _parseDetails(e.response?.data);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Failure(
          message: 'Request timed out. Please try again.',
          details: parsedDetails,
        );

      case DioExceptionType.badResponse:
        return Failure(
          message: _getErrorMessage(e.response?.statusCode),
          statusCode: e.response?.statusCode,
          details: parsedDetails,
        );

      case DioExceptionType.cancel:
        return Failure(
          message: 'Request was cancelled.',
          details: parsedDetails,
        );

      default:
        return Failure(
          message: 'An unexpected error occurred.',
          details: parsedDetails,
        );
    }
  }

  static Failure fromException(Exception e) {
    return Failure(
      message: 'An unexpected error occurred.',
      details: e.toString(),
    );
  }

  /// New method to handle any error
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return Failure.fromDioError(error);
    } else if (error is Exception) {
      return Failure.fromException(error);
    } else {
      return Failure(
        message: 'An unknown error occurred.',
        details: error.toString(),
      );
    }
  }

  static String _getErrorMessage(int? statusCode) {
    if (statusCode == null) return 'Unknown error occurred.';
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 403:
        return 'Access denied.';
      case 404:
        return 'Resource not found.';
      case 405:
        return 'Method not allowed.';
      case 408:
        return 'Request timeout. Please try again later.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      case 504:
        return 'Gateway timeout. Please try again later.';
      default:
        return 'Error: $statusCode. Please try again.';
    }
  }


  static dynamic _parseDetails(dynamic data) {
    if (data is String) {
      try {
        return jsonDecode(data);
      } catch (e) {

        return data;
      }
    }
    return data;
  }
}
