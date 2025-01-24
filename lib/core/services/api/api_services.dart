import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../dependency_injection.dart';
import '../../utils/app_log.dart';
import '../hive.dart';


const String applicationJson = 'application/json';
const String apiKey = '11223344';

class ApiServices {
  ApiServices._internal()
      : _dio = Dio(
    BaseOptions(
      baseUrl: 'https://gold-hamster-143901.hostingersite.com/api/',
      connectTimeout: const Duration(milliseconds: 8000),
      receiveTimeout: const Duration(milliseconds: 8000),
      sendTimeout: const Duration(milliseconds: 8000),
      receiveDataWhenStatusError: true,
    ),
  ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          AppLogs().debugLog('API Request to: ${options.baseUrl}${options.path}');
          AppLogs().debugLog('Request Data: ${options.data}');
          AppLogs().debugLog('Request Query Parameters: ${options.queryParameters}');

          final userToken = await _getTokenFromLocalStorage();

          if (userToken != null) {
            options.headers['Authorization'] = 'Bearer $userToken';
            AppLogs().debugLog('Authorization Header Set: Bearer $userToken');
          }

          final currentLang = await _getLangFromHive();
          if (currentLang != null) {
            options.headers['Accept-Language'] = currentLang;
            AppLogs().debugLog('Accept-Language Header Set: $currentLang');
          }
          options.headers['Accept'] = applicationJson;
          options.headers['api-key'] = apiKey;

          handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          AppLogs().successLog(
              'API Response from: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
          AppLogs().debugLog('Response Status Code: ${response.statusCode}');
          AppLogs().debugLog('Response Data: ${response.data}');
          handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          AppLogs().errorLog('API Error: ${e.message}', error: e, stackTrace: e.stackTrace);
          AppLogs().debugLog('Error Response: ${e.response}');
          handler.next(e);
        },
      ),
    );
  }

  factory ApiServices() {
    return _instance;
  }

  static final ApiServices _instance = ApiServices._internal();
  final Dio _dio;

  Future<String?> _getLangFromHive() async {
    return di<HiveLocalStorage>().getLocale();
  }

  Future<String?> _getTokenFromLocalStorage() async {
    return di<HiveLocalStorage>().get(apiToken);
  }

  Future<Map<String, dynamic>> get({
    required String endPoint,
    Map<String, dynamic>? parameters,
  }) async {
    final Response response = await _dio.get(endPoint, queryParameters: parameters);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? parameters,
  }) async {
    final Response response = await _dio.post(endPoint, queryParameters: parameters, data: data);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? parameters,
  }) async {
    final Response response = await _dio.put(endPoint, queryParameters: parameters, data: data);
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? parameters,
  }) async {
      final Response response =
      await _dio.delete(endPoint, queryParameters: parameters, data: data);
      return _parseResponse(response);
  }

  Future<Map<String, dynamic>> uploadFile({
    required String endPoint,
    required FormData data,
  }) async {
      final Response response = await _dio.post(endPoint, data: data);
      return _parseResponse(response);
  }

  Map<String, dynamic> _parseResponse(Response response) {
    if (response.data is Map) {
      return response.data;
    } else if (response.data is List) {
      return {'data': response.data};
    } else if (response.data is String) {
      return {'data': response.data};
    } else {
      throw Exception('Unexpected response format: ${response.data.runtimeType}');
    }
  }
}
