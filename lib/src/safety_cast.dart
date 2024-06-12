import 'package:either_dart/either.dart';

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
  F Function(String) error,
) {
  try {
    var item = fromMap(data.right);
    return Right(item);
  } on TypeError catch (e) {
    return Left(error(e.toString()));
  } on UnsupportedError catch (e) {
    return Left(error(e.toString()));
  } catch (e) {
    return Left(error(e.toString()));
  }
}
