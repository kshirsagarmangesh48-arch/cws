import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import '../utils/common_methods.dart';
import 'interceptors/common_headers_interceptor.dart';
import 'interceptors/retry_interceptor.dart';


class CwsApiClient {
  /// dio instance
  final Dio _dio;
  String? _baseUrl;

  CwsApiClient(this._dio, this._baseUrl) {
    const flavor = String.fromEnvironment('branch');

    _baseUrl = CommonMethods().getBaseUrl(flavor);
    _dio
      ..options.baseUrl = _baseUrl ?? ''
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.sendTimeout = const Duration(seconds: 60)
      ..options.headers = <String, dynamic>{}
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
            logPrint: print), // LogInterceptor
        CommonHeadersInterceptor(),
        RetryInterceptor(
          dio: _dio,
          retries: 3, // retry count (optional)
          retryDelays: const [
            // set delays between retries (optional)
            Duration(seconds: 3), // wait 1 sec before first retry
            Duration(seconds: 5), // wait 2 sec before second retry
            Duration(seconds: 8), // wait 3 sec before third retry
          ],
        ),
      ]);
    if(!kIsWeb){
      final httpClient = HttpClient()
        ..idleTimeout = const Duration(minutes: 30);
      _dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          return httpClient;
        },
      );

    }
  }

  // Get:-----------------------------------------------------------------------
  Future<Map<String, dynamic>> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message']??'';
      errorResponse['statusCode'] = e.response?.statusCode;
      return errorResponse;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Map<String, dynamic>> post(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isDownload,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['statusCode'] = e.response?.statusCode;
      errorResponse['message'] = e.response?.data['message'];
      return errorResponse;
    }
  }

  Future<Response?> getWithoutJson(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isDownload,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.get<dynamic>(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message'];
      errorResponse['statusCode'] = e.response?.statusCode;
      return null;
    }
  }

  Future<Response?> postWithoutJson(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? isDownload,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.post<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future<Response?> deleteWithoutJson(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.delete<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }


  Future<Map<String, dynamic>> patch(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.patch<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message'];
      errorResponse['statusCode'] = e.response?.statusCode;
      return errorResponse;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Map<String, dynamic>> put(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.put<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message'];
      errorResponse['statusCode'] = e.response?.statusCode;
      return errorResponse;
    }
  }

  Future<bool> download({required String url, required String path}) async {
    try {
      final response = await _dio.download(url, path);
      if(response.statusCode==200) {
        return true;
      }
      return false;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message'];
      errorResponse['statusCode'] = e.response?.statusCode;
      return false;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Map<String, dynamic>> delete(
      String uri, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? showSuccessMessage,
      }) async {
    try {
      final response = await _dio.delete<dynamic>(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      final errorResponse = <String, dynamic>{};
      errorResponse['message'] = e.response?.data['message'];
      errorResponse['statusCode'] = e.response?.statusCode;
      return errorResponse;
    }
  }
}
