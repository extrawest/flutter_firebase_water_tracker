import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_tracker_app/features/feature_home/services/FirebaseCrashlyticsService.dart';
import 'package:water_tracker_app/features/feature_home/services/firestore_service.dart';

import '../services/login_service.dart';

abstract class LoginRepository {
  Future<void> createUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> loginWithFacebook();

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
  Future<void> createUserWithEmailAndPassword({
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
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await loginService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _addUserDataToFireStore(user);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final user = await loginService.signInWithGoogle();
      _addUserDataToFireStore(user);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> loginWithFacebook() async {
    try {
      final user = await loginService.loginWithFacebook();
      _addUserDataToFireStore(user);
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
