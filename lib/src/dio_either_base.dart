import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

part 'api_exception.dart';
part 'dio_http_interceptor_formatter.dart';
part 'http_common_request.dart';
part 'http_status_code.dart';

class DioEither with HttpCommonRequest {
  static const Duration kconnectTimeout = Duration(milliseconds: 1000);
  static const Duration kreceiveTimeout = Duration(milliseconds: 3000);
  static const Duration ksendTimeout = Duration(milliseconds: 5000);

  DioEither({
    required String baseUrl,
    required Map<String, dynamic> headers,
    required Dio dio,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: kconnectTimeout,
      receiveTimeout: kreceiveTimeout,
      sendTimeout: ksendTimeout,
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
      _dio.interceptors.add(DioInterceptorFormatter(
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
          res: e.response?.data,
        ));
      }
      if (e.type == DioExceptionType.unknown) {
        return Left(ApiException(
          code: e.response?.statusCode,
          message: unkownErrorMsg,
          res: e.response?.data,
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
        res: e.response?.data,
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

const String connectionTimeoutErrorMsg =
    "Unable to establish a connection. The remote server did not respond within the specified time. Please check the server's availability and your network connection.";

const String receiveTimoutErrorMsg =
    "Data reception timeout. The expected data did not arrive from the server within the specified time. Please ensure the server is responsive and try again.";

const String sendTimeoutErrorMsg =
    "Data sending timeout. The data could not be sent to the remote server within the allotted time. This might be due to network congestion or server responsiveness issues.";

const String formatExceptionMsg = 'Something error, data cannot proceed';

const String unkownErrorMsg =
    "Something error, check your internet connection.";

const badCertificateMsg = "Unknown Bad Certificate";

const cancelMsg = "Unknown Request Canceled";
