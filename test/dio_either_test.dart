import 'package:dio/dio.dart';
import 'package:dio_either/dio_either.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';

void main() {
  final dio = Dio();
  final dioMock = DioAdapter(dio: dio);
  const String baseUrl = 'https://example.com';
  const String path = '/test';
  const Map<String, dynamic> successResponse = {
    "code": 200,
    "data": {},
  };
  const Map<String, dynamic> failureResponse = {
    "error": "something Error",
  };

  Null internalServerErrorResponse;

  const Map<String, dynamic> headers = {};

  group('DioEither Test', () {
    setUp(() {
      dio.httpClientAdapter = dioMock;
    });

    test('GET method Success', () async {
      // mocking GET method success response
      dioMock.onGet(path, (server) {
        server.reply(200, successResponse);
      });

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.get(
        path,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });

    test('GET method Failure', () async {
      // mocking GET method failure response
      dioMock.onGet(path, (server) {
        // forbiden failure example
        server.reply(403, failureResponse);
      });

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.get(
        path,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });

    test('POST method Success', () async {
      // mocking POST method success response
      var dataUploaded = {};
      dioMock.onPost(
        path,
        (server) {
          server.reply(200, successResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.post(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });
    test('POST method Failure', () async {
      // mocking GET method success response
      var dataUploaded = {};
      dioMock.onPost(
        path,
        (server) {
          server.reply(403, failureResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.post(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });

    test('DELETE method Success', () async {
      // mocking DELETE method success response
      var dataUploaded = {};
      dioMock.onDelete(
        path,
        (server) {
          server.reply(200, successResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.delete(
        path,
        data: dataUploaded,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });

    test('DELETE method Failure', () async {
      // mocking DELETE method success response
      var dataUploaded = {};
      dioMock.onDelete(
        path,
        (server) {
          server.reply(403, failureResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.delete(
        path,
        data: dataUploaded,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });

    test('PUT method Success', () async {
      // mocking PUT method success response
      var dataUploaded = {};
      dioMock.onPut(
        path,
        (server) {
          server.reply(200, successResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.put(
        path,
        data: dataUploaded,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });

    test('PUT method Failure', () async {
      // mocking PUT method success response
      var dataUploaded = {};
      dioMock.onPut(
        path,
        (server) {
          server.reply(403, failureResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.put(
        path,
        data: dataUploaded,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });

    test('HEAD method Success', () async {
      // mocking HEAD method success response
      var dataUploaded = {};
      dioMock.onHead(
        path,
        (server) {
          server.reply(200, successResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.head(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });

    test('HEAD method Failure', () async {
      // mocking HEAD method success response
      var dataUploaded = {};
      dioMock.onHead(
        path,
        (server) {
          server.reply(403, failureResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.head(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });

    test('PATCH method Success', () async {
      // mocking PATCH method success response
      var dataUploaded = {};
      dioMock.onPatch(
        path,
        (server) {
          server.reply(200, successResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.patch(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherSuccess;

      if (res.isRight) {
        eitherSuccess = res.right;
      }

      expect(eitherSuccess, successResponse);
    });

    test('PATCH method Failure', () async {
      // mocking PATCH method success response
      var dataUploaded = {};
      dioMock.onPatch(
        path,
        (server) {
          server.reply(403, failureResponse);
        },
        data: dataUploaded,
      );

      final DioEither dioEither = DioEither(
        baseUrl: baseUrl,
        headers: headers,
        dio: dio,
      );

      final res = await dioEither.patch(
        path,
        dataUploaded,
        showLog: true,
      );

      dynamic eitherFailure;

      if (res.isLeft) {
        eitherFailure = res.left.response;
      }

      expect(eitherFailure, failureResponse);
    });
  });

  test('GET method 500 Internal Server Error', () async {
    // mocking GET method success response
    dioMock.onGet(path, (server) {
      server.reply(500, internalServerErrorResponse);
    });

    final DioEither dioEither = DioEither(
      baseUrl: baseUrl,
      headers: headers,
      dio: dio,
    );

    final res = await dioEither.get(
      path,
      showLog: true,
      retries: 0,
    );

    dynamic eitherSuccessOrFailure;

    if (res.isLeft) {
      eitherSuccessOrFailure = res.left.response;
    }

    if (res.isRight) {
      eitherSuccessOrFailure = res.right;
    }

    expect(eitherSuccessOrFailure, null);
  });

  test('GET method retries simulation 3 times -> 0,1,2 error | 3 Success',
      () async {
    // mocking GET method seqeuntial twice error then success
    dioMock.onGet(path, (server) async {
      server.reply(500, internalServerErrorResponse);
      await Future.delayed(Duration(seconds: 2));
      server.reply(500, internalServerErrorResponse);
      await Future.delayed(Duration(seconds: 4));
      server.reply(500, internalServerErrorResponse);
      await Future.delayed(Duration(seconds: 6));
      server.reply(200, internalServerErrorResponse);
    });

    final DioEither dioEither = DioEither(
      baseUrl: baseUrl,
      headers: headers,
      dio: dio,
    );

    final res = await dioEither.get(
      path,
      name: "Get Something Repository Test",
      showLog: true,
      retries: 3,
      retryDelays: [
        Duration(seconds: 2),
        Duration(seconds: 4),
        Duration(seconds: 6),
      ],
    );

    dynamic eitherSuccessOrFailure;

    if (res.isLeft) {
      eitherSuccessOrFailure = res.left.response;
    }

    if (res.isRight) {
      eitherSuccessOrFailure = res.right;
    }

    expect(eitherSuccessOrFailure, null);
  });
}
