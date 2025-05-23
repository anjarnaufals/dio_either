// ignore_for_file: prefer-match-file-name

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_either/dio_either.dart';
import 'package:either_dart/either.dart';

import 'todo.dart';
import 'your_error.dart';

const String baseUrl = 'https://jsonplaceholder.typicode.com';
const String postlistUrl = '/comments';
const Map<String, dynamic> query = {"postId": "1"};
const Map<String, String> _constHeader = {
  HttpHeaders.acceptHeader: "accept: application/json",
};

void main() async {
  var data = await getPostList();
  if (data.isLeft) {
    handleErrorCase();
  } else {
    handleSuccessCase();
  }
}

void handleErrorCase() {
  return;
}

void handleSuccessCase() {
  return;
}

class YourClient {
  static Future<Map<String, String>> _authorization() async {
    //your logic token case
    final token = '';
    final authorizationHeader = {
      HttpHeaders.acceptHeader: "accept: application/json",
      HttpHeaders.authorizationHeader: 'Bearer $token',
      //your unique device id system
      "Device-ID": Platform.isAndroid ? 'Unique.androidId' : ' Unique.iosId',
    };

    return authorizationHeader;
  }

  Future<DioEither> call({
    bool useAuthentication = false,
  }) async {
    return DioEither(
      baseUrl: baseUrl,
      headers: useAuthentication ? await _authorization() : _constHeader,
      dio: Dio(),
    );
  }
}

// Repository GET todo list
Future<Either<YourError, List<Todo>>> getPostList() async {
  final YourClient yourClient = YourClient();
  try {
    var data = await yourClient.call().then((http) => http.get(
          postlistUrl,
          query: query,
          showLog: true,
          name: "getPostList",
        ));

    if (data.isLeft) {
      final yourError = YourError(
        code: data.left.code,
        msg: data.left.message,
      );

      return Left(yourError);
    } else {
      final todoList = List<Todo>.from(
        List.from(data.right).map((e) => Todo.fromMap(e)),
      ).toList();

      return Right(todoList);

      // or you can use safetyParse for handling type cast error when
      // parse data raw map<String,dynamic> to model
      // var unknown = await getUknown();

      // return safetyCast(
      //   unknown,
      //   (data) => List<Todo>.from(
      //     List.from(data).map((e) => Todo.fromMap(e)),
      //   ).toList(),
      //   (error) => YourError(msg: error),
      //   showStacktrace: true,
      // );
    }
  } catch (e) {
    rethrow;
  }
}

Future<Either<dynamic, dynamic>> getUknown() async {
  var uknown = {};
  return Right(uknown);
}
