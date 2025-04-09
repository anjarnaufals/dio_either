import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

part 'api_exception.dart';
part 'dio_http_interceptor_formatter.dart';
part 'http_common_request.dart';

///[DioEither]
/// A base class Dio Either Package
class DioEither with HttpCommonRequest {
  /// default duration for connection timeout in milliseconds
  static const Duration _kconnectTimeout = Duration(milliseconds: 1000);

  /// default duration for receive timeout in milliseconds
  static const Duration _kreceiveTimeout = Duration(milliseconds: 3000);

  /// default duration for send timeout in milliseconds
  static const Duration _ksendTimeout = Duration(milliseconds: 5000);

  /// constructor
  ///
  /// if [kconnectTimeout] is null then [_kconnectTimeout] used
  ///
  /// if [kreceiveTimeout] is null then [_kreceiveTimeout] used
  ///
  /// if [ksendTimeout] is null then [_ksendTimeout] used
  DioEither({
    required String baseUrl,
    required Map<String, dynamic> headers,
    required Dio dio,
    Duration? kconnectTimeout,
    Duration? kreceiveTimeout,
    Duration? ksendTimeout,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: kconnectTimeout ?? _kconnectTimeout,
      receiveTimeout: kreceiveTimeout ?? _kreceiveTimeout,
      sendTimeout: ksendTimeout ?? _ksendTimeout,
      headers: headers,
    );
    _dio = dio;
  }

  late final Dio _dio;

  static const List<Duration> _retryDelaysDefault = [
    Duration(seconds: 1),
    Duration(seconds: 3),
    Duration(seconds: 5)
  ];

  @override
  Future<Either<ApiException, dynamic>> get(
    String url, {
    Map<String, dynamic>? query,
    Object? data,
    bool showLog = false,
    int retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(
      _dio.get(
        url,
        data: data,
        queryParameters: query,
      ),
    );
  }

  @override
  Future<Either<ApiException, dynamic>> post<T>(
    String url,
    T? data, {
    Map<String, dynamic>? query,
    bool showLog = false,
    int retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(_dio.post(
      url,
      data: data,
      queryParameters: query,
    ));
  }

  @override
  Future<Either<ApiException, dynamic>> put<T>(
    String url, {
    T? data,
    Map<String, dynamic>? query,
    bool showLog = false,
    int retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(_dio.put(
      url,
      data: data,
      queryParameters: query,
    ));
  }

  @override
  Future<Either<ApiException, dynamic>> delete<T>(
    String url, {
    Map<String, dynamic>? query,
    showLog = false,
    T? data,
    retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(
      _dio.delete(
        url,
        data: data,
        queryParameters: query,
      ),
    );
  }

  @override
  Future<Either<ApiException, dynamic>> head<T>(
    String url,
    T? data, {
    Map<String, dynamic>? query,
    bool showLog = false,
    int retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(
      _dio.head(url, queryParameters: query, data: data),
    );
  }

  @override
  Future<Either<ApiException, dynamic>> patch<T>(
    String url,
    T? data, {
    Map<String, dynamic>? query,
    bool showLog = false,
    int retries = 3,
    List<Duration>? retryDelays,
    String? name,
  }) async {
    if (showLog) {
      _dio.interceptors.add(DioHttpInterceptorFormatter(
        reposName: name ?? "",
      ));
    }

    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      retries: retries,
      logPrint: log,
      retryDelays: retryDelays ?? _retryDelaysDefault,
    ));

    return await _eitherCallDio(_dio.patch(
      url,
      data: data,
      queryParameters: query,
    ));
  }

  Future<Either<ApiException, dynamic>> _eitherCallDio(
    Future<Response> dioHttpRequest,
  ) async {
    try {
      var res = await dioHttpRequest;

      return Right(res.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: connectionTimeoutErrorMsg,
        ));
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: receiveTimoutErrorMsg,
        ));
      }
      if (e.type == DioExceptionType.sendTimeout) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: sendTimeoutErrorMsg,
        ));
      }
      if (e.type == DioExceptionType.badResponse) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: e.message,
          response: e.response?.data,
        ));
      }
      if (e.type == DioExceptionType.unknown) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: unkownErrorMsg,
          response: e.response?.data,
        ));
      }
      if (e.type == DioExceptionType.badCertificate) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: badCertificateMsg,
        ));
      }
      if (e.type == DioExceptionType.cancel) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: cancelMsg,
        ));
      }

      return Left(ApiException(
        code: e.response?.statusCode,
        message: e.message,
        response: e.response?.data,
      ));
    } on FormatException {
      return Left(
        const ApiException(
          message: formatExceptionMsg,
        ),
      );
    }
  }
}

/// default message for connection timeout error
const String connectionTimeoutErrorMsg =
    "Unable to establish a connection. The remote server did not respond within the specified time. Please check the server's availability and your network connection.";

/// default message for reception timeout error
const String receiveTimoutErrorMsg =
    "Data reception timeout. The expected data did not arrive from the server within the specified time. Please ensure the server is responsive and try again.";

/// default message for sending timeout error
const String sendTimeoutErrorMsg =
    "Data sending timeout. The data could not be sent to the remote server within the allotted time. This might be due to network congestion or server responsiveness issues.";

/// default message for formating exception error
const String formatExceptionMsg = 'Something error, data cannot proceed';

/// default message for unknown error
const String unkownErrorMsg =
    "Something error, check your internet connection.";

/// default message for Unknown Bad Certificate
const badCertificateMsg = "Unknown Bad Certificate";

/// default message for requst canceled
const cancelMsg = "Unknown Request Canceled";
