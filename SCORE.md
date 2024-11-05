# Pana Analyzer Report

## Overview

**Total Points**: 130/160

---

## ❌ Follow Dart File Conventions (10/30)

### ✗ 0/10 points: Provide a Valid `pubspec.yaml`
- **Description Too Short**: Add more details to the `description` field of `pubspec.yaml` (60–180 characters) to describe the package, its purpose, and target use case.

### ✔ 5/5 points: Provide a Valid `README.md`

### ✔ 5/5 points: Provide a Valid `CHANGELOG.md`

### ✗ 0/10 points: Use an OSI-Approved License
- **No Recognized License**: Add an [OSI-approved license](https://opensource.org/licenses) in the `LICENSE` file to increase accessibility for the community.

---

## ❌ Provide Documentation (10/20)

### ✗ 0/10 points: API Documentation Coverage
- **Insufficient Coverage**: 6 out of 61 API elements (9.8%) have documentation comments. Improve documentation to cover at least 20% of the public API.
- To highlight missing documentation, enable the [`public_member_api_docs`](https://dart.dev/tools/linter-rules/public_member_api_docs) lint rule.
- Some undocumented API elements:
  - `dio_either.ApiException`
  - `dio_either.ApiException.ApiException`
  - `dio_either.ApiException.code`
  - `dio_either.ApiException.message`
  - `dio_either.ApiException.res`

### ✔ 10/10 points: Example Provided
- **Example**: A valid example is included in the package.

---

## ✅ Platform Support (20/20)

### ✔ 20/20 points: Multi-Platform Compatibility
- **Supported Platforms**: Android, iOS, Windows, Linux, macOS
- **Unsupported Platform**: Web
  - **Incompatibility Reason**: `package:logger/logger.dart` imports `dart:io`, which is not web-compatible.

### ⚠️ 0/0 points: WASM Compatibility
- **Incompatibility Reason**: `package:logger/logger.dart` imports `dart:io`, making it incompatible with WebAssembly (WASM).

---

## ✅ Pass Static Analysis (50/50)

### ✔ 50/50 points: No Errors, Warnings, or Formatting Issues
- **Linting**: Code passes all static analysis checks with no issues.

---

## ✅ Support Up-to-Date Dependencies (40/40)

### ✔ 10/10 points: Latest Version Dependencies
- **Dependencies Up-to-Date**: All package dependencies are supported in their latest versions.

| Package                | Constraint   | Compatible | Latest |
| ---------------------- | ------------ | ---------- | ------ |
| [`dio`](https://pub.dev/packages/dio) | `^5.5.0+1` | 5.7.0     | 5.7.0  |
| [`dio_smart_retry`](https://pub.dev/packages/dio_smart_retry) | `^6.0.0` | 6.0.0     | **7.0.1** |
| [`either_dart`](https://pub.dev/packages/either_dart) | `^1.0.0` | 1.0.0     | 1.0.0  |
| [`http_mock_adapter`](https://pub.dev/packages/http_mock_adapter) | `^0.6.1` | 0.6.1     | 0.6.1  |
| [`logger`](https://pub.dev/packages/logger) | `^2.3.0` | 2.4.0     | 2.4.0  |

> ⚠️ **Warning**: `dio_smart_retry` 7.0.1 is available. Update to this version to maintain full points when the package is 30 days old.

### ✔ 10/10 points: Latest Stable Dart and Flutter SDKs Supported

### ✔ 20/20 points: Dependency Lower Bounds Compatibility
- **Compatibility Check**: `pub downgrade` shows no static analysis errors.

---

**Note**: To reproduce the above results, run:
```bash
dart pub outdated --no-dev-dependencies --up-to-date --no-dependency-overrides
