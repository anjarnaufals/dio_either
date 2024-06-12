import 'dart:io';

import 'package:dio_either/dio_either.dart';
import 'package:either_dart/either.dart';

import 'todo.dart';
import 'your_error.dart';

// set tup
// https://jsonplaceholder.typicode.com
// remove https://
const String baseUrl = 'https://jsonplaceholder.typicode.com';
const String postlistUrl = '/comments';
const Map<String, dynamic> query = {"postId": "1"};
const Map<String, String> _constHeader = {};

void main() async {
  var data = await getPostList();
  if (data.isLeft) {
    // do your error case
  } else {
    // do your success case
  }
}

class YourClient {
  static Future<Map<String, String>> _authorization() async {
    //your logic token case
    final token = '';
    final authorizationHeader = {
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
      acceptHeaders: {
        HttpHeaders.acceptHeader: "accept: application/json",
      },
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

      // return safetyCast(
      //   data,
      //   (data) => List<Todo>.from(
      //     List.from(data).map((e) => Todo.fromMap(e)),
      //   ).toList(),
      //   (error) => YourError(msg: error),
      // );
    }
  } catch (e) {
    rethrow;
  }
}
