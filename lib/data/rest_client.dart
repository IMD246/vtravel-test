// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class RestClient {
  static const TIMEOUT = 30000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';
  static const LANGUAGE = 'Accept-Language';
  late String baseUrl;
  late Map<String, dynamic> headers;
  // singleton
  static final RestClient instance = RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  void init(
    String baseUrl, {
    String? platform,
    String? deviceId,
    String? language,
    String? appVersion,
    String? accessToken,
  }) {
    this.baseUrl = baseUrl;
    headers = {
      'Content-Type': 'application/json',
      'X-Version': appVersion,
      'X-Platform': platform,
      'x-device-id': deviceId
    };
    if (accessToken != null) setToken(accessToken);
    setLanguage(language ?? "en");
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = "Bearer $token";
  }

  void setLanguage(String language) {
    headers[LANGUAGE] = language;
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
  }

  static Dio getDio({String? customUrl, bool isUpload = false}) {
    var dio = Dio(
        instance.getDioBaseOption(customUrl: customUrl, isUpload: isUpload));

    /// Check expire time
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, handler) async {},
    ));

    return dio;
  }

  BaseOptions getDioBaseOption({String? customUrl, bool isUpload = false}) {
    return BaseOptions(
      baseUrl: customUrl ?? instance.baseUrl,
      connectTimeout: const Duration(milliseconds: TIMEOUT),
      receiveTimeout: const Duration(milliseconds: TIMEOUT),
      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }
}
