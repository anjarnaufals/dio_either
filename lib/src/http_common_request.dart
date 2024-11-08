part of 'dio_either_base.dart';

abstract mixin class HttpCommonRequest {
  Future get(
    String url, {
    Map<String, dynamic>? query,
    bool showLog = false,
  });
  Future post<T>(
    String url,
    T? data, {
    bool showLog = false,
  });
  Future put<T>(
    String url, {
    T? data,
    Map<String, dynamic>? query,
    bool showLog = false,
  });
  Future delete<T>(
    String url, {
    T? data,
    bool showLog = false,
  });
  Future patch<T>(
    String url,
    T? data, {
    bool showLog = false,
  });
  Future head<T>(
    String url,
    T? data, {
    Map<String, dynamic>? query,
    bool showLog = false,
  });
}
