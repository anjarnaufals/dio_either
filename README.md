
# dio_either

`dio_either` is a Dart package designed to simplify HTTP request handling by integrating the capabilities of Dio, dio_smart_retry, and Logger. It streamlines both response and error handling, offering a functional retry mechanism by simply setting a `retry` parameter to the desired number of attempts. Additionally, it enables HTTP request logging with the Logger package, providing a comprehensive and efficient solution for managing HTTP interactions in Dart and Flutter applications.

## Features 

- **Unified HTTP Handling** : Combines Dio, dio_smart_retry, and Logger to provide a streamlined approach to making HTTP requests in Dart and Flutter applications. 
-  **Simplified Response & Error Handling** : Automatically wraps HTTP responses in `Either` types, allowing for clear and consistent error management. 
- **Functional Retry Mechanism** : Easily enable request retries by setting the `retry` parameter to the desired number of attempts, making error recovery straightforward. 
- **Integrated Request Logging** : Provides comprehensive HTTP request and response logging using the Logger package, enabling better insight into network interactions.
- **Testability with Mocking Support**: Accepts Dio as a parameter, enabling flexible testing by allowing mocked Dio requests using `http_mock_adapter`.

## Dependencies

| Dependency | Version | Link | 
|--------------------|----------|----------------------------------------------| 
| `dio` | ^5.8.0+1 	 | [dio on pub.dev](https://pub.dev/packages/dio) | 
| `dio_smart_retry`  | ^7.0.1 | [dio_smart_retry on pub.dev](https://pub.dev/packages/dio_smart_retry) |
| `either_dart`      | ^1.0.0 | [either_dart on pub.dev](https://pub.dev/packages/either_dart) |
| `http_mock_adapter`| ^0.6.1 | [http_mock_adapter on pub.dev](https://pub.dev/packages/http_mock_adapter) | 
| `logger` | ^2.4.0  | [logger on pub.dev](https://pub.dev/packages/logger) |


## Installation

Add `dio_either` to your `pubspec.yaml` file:

```yaml
dio_either:
    git:
      url: https://github.com/anjarnaufals/dio_either.git
      ref: main
```

## Example

example you create the client class
```dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_either/dio_either.dart';

class YourClient {
  static Future<Map<String, String>> _authorization() async {
	//something
    final authorizationHeader = { };
    return authorizationHeader;
  }

  Future<DioEither> call({
    bool useAuthentication = false,
  }) async {
    return DioEither(
      baseUrl: "https://jsonplaceholder.typicode.com", 
      headers: useAuthentication ? await _authorization() : _constHeader,
      dio: Dio(),
    );
  }
}
```

example Repository GET todo list
```dart
Future<Either<YourError, List<Todo>>> getPostList() async {
  final YourClient yourClient = YourClient();
  try {
	var request =  await yourClient.call();
    var raw = await reqeust.get(
          "/comments", // Your API URL
          query: {"postId": "1"},
          showLog: true,
          name: "getPostList()",
        );

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
    }
  } catch (e) {
    rethrow;
  }
}
```
More details see example folder.
