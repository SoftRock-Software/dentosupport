import 'package:dento_support/core/exceptions/client_exception.dart';
import 'package:dento_support/core/exceptions/network_exception.dart';
import 'package:dento_support/core/exceptions/network_response_exception.dart';
import 'package:dento_support/core/services/local_storage_service.dart';
import 'package:dento_support/injector.dart';
import 'package:dento_support/routers/route_utils.dart';
import 'package:dento_support/routers/router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// A callback that returns a Dio response, presumably from a Dio method
/// it has called which performs an HTTP request, such as `dio.get()`,
/// `dio.post()`, etc.
typedef HttpClientRequest<T> = Future<Response<T>> Function();

/// Function which takes a Dio response object and an exception and returns
/// an optional [ClientException], optionally mapping the response
/// to a custom exception.
typedef ResponseExceptionMapper = NetworkResponseException<Exception, dynamic>?
    Function<T>(
  Response<T>,
  Exception,
);

class DioClient {
  DioClient(
    this._dio, {
    required String baseUrl,
    this.exceptionMapper,
  }) : _baseUrl = baseUrl {
    _dio
      ..options.baseUrl = _baseUrl
      ..options.contentType = 'application/json';

    _dio.interceptors.add(
      LogInterceptor(
        request: false,
        requestHeader: false,
        responseHeader: false,
        responseBody: true,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.uri.path.contains('sendOTP') == false) {
            _token = getIt<LocalStorageService>().token;
            options.headers['Authorization'] = 'Bearer $_token';
            debugPrint(_token);
          }

          return handler.next(options);
        },
        // onResponse: (response, handler) {
        //   if (response.data is Map) {
        //     final responseMap = response.data as Map<String, dynamic>;
        //     if (responseMap.containsKey('token')) {
        //       _token = responseMap['token'] as String;
        //     }
        //   }
        //   return handler.next(response);
        // },
        onError: (e, handler) {
          if (e.response?.statusCode == 401) {
            // Handle unauthorized
            getIt<LocalStorageService>().clear();
            router.go(AppPage.signin.toPath);
          }

          return handler.next(e);
        },
      ),
    );
  }

  final Dio _dio;

  /// If provided, this function which will be invoked when a response exception
  /// occurs, allowing the response exception to be mapped to a custom
  /// exception class which extends [ClientException].
  final ResponseExceptionMapper? exceptionMapper;
  final String _baseUrl;
  String _token = '';

  Future<Response<dynamic>> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _mapException(
      () => _dio.get(uri, queryParameters: queryParameters),
    );
  }

  Future<Response<dynamic>> patch(
    String uri, {
    dynamic data,
    bool? formRequest,
  }) async {
    try {
      return await _dio.patch(
        uri,
        data: formRequest != null && formRequest
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<Response<T>> post<T>(
    String uri, {
    dynamic data,
    bool? formRequest,
  }) async {
    return _mapException(
      () => _dio.post(
        uri,
        data: formRequest != null && formRequest
            ? FormData.fromMap(data as Map<String, dynamic>)
            : data,
      ),
    );
  }

  Future<Response<T>> delete<T>(String uri, {dynamic data}) async {
    return _mapException(() => _dio.delete(uri, data: data));
  }

  // Map Dio exceptions (and any other exceptions) to an exception type
  // supported by our application.
  // Simplified with single Exception [AppException]
  Future<Response<T>> _mapException<T>(HttpClientRequest<T> request) async {
    try {
      return await request();
    } on DioError catch (exception) {
      switch (exception.type) {
        case DioErrorType.connectionTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.connectionError:
          throw NetworkException(
            reason: NetworkExceptionReason.timedOut,
            exception: exception,
          );
        case DioErrorType.badResponse:
          // For DioErrorType.response, we are guaranteed to have a
          // response object present on the exception.
          final response = exception.response;
          // if (response == null || response is! Response<T>) {
          if (response == null) {
            // This should never happen, judging by the current source code
            // for Dio.
            throw NetworkResponseException<DioError, dynamic>(
              exception: exception,
            );
          }

          throw exceptionMapper?.call(response, exception) ??
              NetworkResponseException(
                exception: exception,
                statusCode: response.statusCode,
                data: response.data,
              );
        case DioErrorType.cancel:
          throw NetworkException(
            reason: NetworkExceptionReason.canceled,
            exception: exception,
          );
        case DioErrorType.badCertificate:
        case DioErrorType.unknown:
          throw NetworkException(
            reason: NetworkExceptionReason.canceled,
            exception: exception,
          );
        // throw ClientException(exception: exception);
      }
    } catch (e) {
      throw ClientException(
        exception: e is Exception ? e : Exception('Unknown exception ocurred'),
      );
    }
  }
}
