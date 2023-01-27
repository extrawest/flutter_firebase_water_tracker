import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class FirebaseCrashlyticsService {
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason});
}

class FirebaseCrashlyticsServiceImpl implements FirebaseCrashlyticsService {
  final FirebaseCrashlytics _crashlytics;

  FirebaseCrashlyticsServiceImpl({FirebaseCrashlytics? crashlytics})
      : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance;

  @override
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason}) async {
    await _crashlytics.recordError(message, stackTrace, reason: reason);
  }
}
