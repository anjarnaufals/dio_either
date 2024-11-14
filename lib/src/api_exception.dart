part of 'dio_either_base.dart';

/// [ApiException]
/// A custom exception model to standardize error responses from Dio, making
/// them structured and easy to read and use in subsequent events.
class ApiException implements Exception {
  /// Creates an [ApiException] with an optional HTTP status code,
  /// error message, and additional response data.
  const ApiException({
    this.code,
    this.message,
    this.response,
  });

  /// The HTTP status code associated with the request (e.g., 404, 500).
  final int? code;

  /// A descriptive error message returned by Dio.
  final String? message;

  /// A generic holder for any additional response or exception data.
  final dynamic response;
}
