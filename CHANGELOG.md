## 1.1.12

- bump dio_smart_retry dependencies
- bump logger dependencies
- update pana score points

### Breaking Change
- `MultipartFileRecreatable` removed from `dio` on `5.7.0`
- start From Migrating to 7.0, `dio_smart_retry` Use `MultipartFile` instead of `MultipartFileRecreatable`.

### Improved
Enhanced documentation and code clarity 
- Updated class-level comment to clearly describe `ApiException`'s purpose as a model for handling standardized error responses from Dio.
- Renamed `res` to `response` for better clarity, and updated its description to emphasize it holds additional data from the response or exception.

## 1.0.11

- bump dio dependencies

## 1.0.10

### Changed
- **`showlog`**: Changed variable type from `dynamic` to `bool` for better type safety.
- **`retries`**: Changed variable type from `dynamic` to `int` to ensure consistent handling of retry counts.

### Added
- **`retryDelays`** in `COMMON REQUEST`:
  - Specifies the delays between retry attempts.
  - If the number of attempts (defined by `retries`) exceeds the number of values in `retryDelays`, the final value in `retryDelays` will be used for subsequent retries.
  - `name` parameter to `something` function to display function name in console logs.


## 1.0.9

- bump dio dependencies


## 1.0.8

- update dependencies
- refactor DioInterceptorFormatter 

## 1.0.7

- Add logging stacktrace on safety cast function

## 1.0.6

- Add safety cast model capability

## 1.0.5

- Change Data paramaters become nullable on PUT Method

## 1.0.4

- Change Data paramaters become nullable on PUT Methodd

## 1.0.3

- add query parameters on PUT method

## 1.0.2

- update dependency dio, logger
- update sdk minimum

## 1.0.1

- add type to all parameter and become required
- add new parameter dio instance for moking
- add test mocking dioeither
- update example
- refactor head, patch method on dioeither base

## 1.0.0

- Initial version.
