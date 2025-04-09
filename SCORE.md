# Pana Analyzer Report

## Overview

**Total Points**: 160/160

---

## ✓ Follow Dart file conventions (30 / 30)

### ✔ 10/10 points: Provide a valid `pubspec.yaml`

### ✔ 5/5 points: Provide a Valid `README.md`

### ✔ 5/5 points: Provide a Valid `CHANGELOG.md`

### ✔ 10/10 points: Use an OSI-approved license

- Detected license: `Unlicense`.

---

## ✓ Provide documentation (20 / 20)

### ✗ 10/10 points: 20% or more of the public API has dartdoc comments

36 out of 36 API elements (100.0 %) have documentation comments.

### ✔ 10/10 points: Package has an example

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

| Package | Constraint | Compatible | Latest |

| ---------------------- | ------------ | ---------- | ------ |

| [`dio`](https://pub.dev/packages/dio) | ` 5.7.0` | 5.7.0 | 5.7.0 |

| [`dio_smart_retry`](https://pub.dev/packages/dio_smart_retry) | `^7.0.1` | 6.0.0 | **7.0.1** |

| [`either_dart`](https://pub.dev/packages/either_dart) | `^1.0.0` | 1.0.0 | 1.0.0 |

| [`http_mock_adapter`](https://pub.dev/packages/http_mock_adapter) | `^0.6.1` | 0.6.1 | 0.6.1 |

| [`logger`](https://pub.dev/packages/logger) | `^2.4.0` | 2.4.0 | 2.4.0 |

### ✔ 10/10 points: Latest Stable Dart and Flutter SDKs Supported

### ✔ 20/20 points: Dependency Lower Bounds Compatibility

- **Compatibility Check**: `pub downgrade` shows no static analysis errors.

---

**Note**: To reproduce the above results, run:

```bash

dart  pub  outdated  --no-dev-dependencies  --up-to-date  --no-dependency-overrides
```
