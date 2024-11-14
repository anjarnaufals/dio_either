part of 'dio_either_base.dart';

/// interface for HTTP request methods
abstract mixin class HttpCommonRequest {
  /// GET methods
  Future get(
    String url, {
    Map<String, dynamic>? query,
    bool showLog = false,
  });

  /// POST methods
  Future post<T>(
    String url,
    T? data, {
    bool showLog = false,
  });

  /// PUT methods
  Future put<T>(
    String url, {
    T? data,
    Map<String, dynamic>? query,
    bool showLog = false,
  });

  /// delete methods
  Future delete<T>(
    String url, {
    T? data,
    bool showLog = false,
  });

  /// PATCH methods
  Future patch<T>(
    String url,
    T? data, {
    bool showLog = false,
  });

  /// HEAD methods
  Future head<T>(
    String url,
    T? data, {
    Map<String, dynamic>? query,
    bool showLog = false,
  });
}
