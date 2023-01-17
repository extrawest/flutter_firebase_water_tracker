import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_tracker_app/features/feature_home/services/firebase_crashlytics_service.dart';
import 'package:water_tracker_app/features/feature_home/services/firestore_service.dart';

import '../services/login_service.dart';

abstract class LoginRepository {
  Future<User> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithGoogle();

  Future<User> loginWithFacebook();

  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason});
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;
  final FirestoreService fireStoreService;
  final FirebaseCrashlyticsService firebaseCrashlyticsService;

  const LoginRepositoryImpl({
    required this.loginService,
    required this.fireStoreService,
    required this.firebaseCrashlyticsService,
  });

  @override
  Future<User> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await loginService.createUserWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      await _addUserDataToFireStore(user);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await loginService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _addUserDataToFireStore(user);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> signInWithGoogle() async {
    try {
      final user = await loginService.signInWithGoogle();
      _addUserDataToFireStore(user);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User> loginWithFacebook() async {
    try {
      final user = await loginService.loginWithFacebook();
      _addUserDataToFireStore(user);
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> _addUserDataToFireStore(User user) async {
    await fireStoreService.setUserDocument(
      data: {
        'name': user.displayName,
        'email': user.email,
        'photo_url': user.photoURL,
        'daily_goal': 4000,
      },
    );
  }

  @override
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason}) {
    return firebaseCrashlyticsService.recordError(message, stackTrace, reason: reason);
  }
}
