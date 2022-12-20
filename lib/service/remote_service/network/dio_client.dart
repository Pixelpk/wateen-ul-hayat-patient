// Package imports:
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../export.dart';

// Project imports:

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  String baseUrl;

  static late Dio _dio;

  final List<Interceptor>? interceptors;
  final LanguageController languageController = LanguageController();

  DioClient(
    this.baseUrl,
    Dio dio, {
    this.interceptors,
  }) {
    _dio = dio;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'accept': '*/*',
      };
    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool skipAuth = false}) async {
    log.d(languageController.lang.value);
    /* try {
      var token = await storage.read(LOCALKEY_token);
      if (token != null) {
        options = Options(headers: {
          "Authorization": "Bearer $token",
          'Lang': languageController.lang.value,
        });
      }*/
    try {
      debugPrint("authorization============ $skipAuth");
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        if (token != null) {
          if (options == null) {
            options = Options(headers: {
              "Authorization": "Bearer $token",
              'lang': (storage.read(LOCALKEY_english) == null ||
                      storage.read(LOCALKEY_english) == true)
                  ? 'en'
                  : 'ar'
            });
          }
        }
      }
      else{
        options = Options(headers: {
          'lang': (storage.read(LOCALKEY_english) == null ||
              storage.read(LOCALKEY_english) == true)
              ? 'en'
              : 'ar'
        });
      }
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool?
          skipAuth // api required Authorization token then pass skip auth false, skipAuth false meanse token not skip
      }) async {
    // If Api no required Authorization token , pass skip auth true (means authorization skip)
    try {
      debugPrint("authorization============ $skipAuth");
      if (skipAuth == false) {
        var token = await storage.read(LOCALKEY_token);
        if (token != null) {
          if (options == null) {
            options = Options(headers: {
              "Authorization": "Bearer $token",
              'lang': (storage.read(LOCALKEY_english) == null ||
                      storage.read(LOCALKEY_english) == true)
                  ? 'en'
                  : 'ar'
            });
          }
        }
      }
      else{
        options = Options(headers: {
          'lang': (storage.read(LOCALKEY_english) == null ||
              storage.read(LOCALKEY_english) == true)
              ? 'en'
              : 'ar'
        });
      }

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var token = await storage.read(LOCALKEY_token);
      if (token != null) {
        options = Options(headers: {
          "Authorization": "Bearer $token",
          'Lang': languageController.lang.value,
        });
      }
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
