// ignore_for_file: public_member_api_docs

part of 'dio_either_base.dart';

/// list of http status code
sealed class HttpStatusCodes {
  // Success
  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  static const int resetContent = 205;

  // Redirection
  static const int permanentRedirect = 301;
  static const int temporaryRedirect = 302;
  static const int seeOther = 303;
  static const int notModified = 304;

  // Client Error
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int methodNotAllowed = 405;
  static const int requestTimeout = 408;

  // Server Error
  static const int internalServerError = 500;
  static const int notImplemented = 501;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}
