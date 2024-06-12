import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

///[safetyCast]
/// Usually used for handling `TypeCast` error when
///
/// parse data `map<String,dynamic>` to `YourModel`
///
/// `F` is your `FailureModel`,
/// `M` is your `YourModel`
///
/// - `data` is your data coming from `EitherFunction`
///
/// - `fromMap` usually is `(data) => YourModel.fromMap()`
///
/// -  `error` usually is `(error) =>FailureModel(error)`
///
/// ***Limitation !***
///
/// ***Make Sure fromMap Callback parameter is Map<String,dynamic>***
///
Either<F, M> safetyCast<F, M>(
  Either<dynamic, dynamic> data,
  M Function(dynamic) fromMap,
  F Function(String) error, {
  bool showStacktrace = false,
}) {
  try {
    var item = fromMap(data.right);
    return Right(item);
  } on TypeError catch (e, t) {
    if (showStacktrace) {
      final Logger logger = Logger();
      logger.e(e.toString(), stackTrace: t);
    }
    return Left(error(e.toString()));
  } on UnsupportedError catch (e, t) {
    if (showStacktrace) {
      final Logger logger = Logger();
      logger.e(e.toString(), stackTrace: t);
    }
    return Left(error(e.toString()));
  } catch (e, t) {
    if (showStacktrace) {
      final Logger logger = Logger();
      logger.e(e.toString(), stackTrace: t);
    }
    return Left(error(e.toString()));
  }
}
