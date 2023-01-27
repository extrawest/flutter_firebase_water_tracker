import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker_app/features/feature_home/services/firebase_crashlytics_service.dart';
import 'package:water_tracker_app/features/feature_home/services/firestore_service.dart';
import 'package:water_tracker_app/features/feature_login/repositories/login_repository.dart';
import 'package:water_tracker_app/features/feature_login/services/login_service.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginService, FirestoreService, FirebaseCrashlyticsService])
void main() {
  late MockLoginService mockLoginService;
  late MockFirestoreService mockFireStoreService;
  late MockFirebaseCrashlyticsService mockFirebaseCrashlyticsService;
  late LoginRepositoryImpl loginRepositoryImpl;

  setUp(() {
    mockLoginService = MockLoginService();
    mockFireStoreService = MockFirestoreService();
    mockFirebaseCrashlyticsService = MockFirebaseCrashlyticsService();
    loginRepositoryImpl = LoginRepositoryImpl(
      loginService: mockLoginService,
      fireStoreService: mockFireStoreService,
      firebaseCrashlyticsService: mockFirebaseCrashlyticsService,
    );
  });

  group('LoginRepositoryImpl', () {
    const email = 'ilyas@yopmail.com';
    const uid = 'sampleUid';
    const displayName = 'ilyas';
    const password = 'Test@123';
    final mockUser = MockUser(
      uid: uid,
      email: email,
      displayName: displayName,
    );

    test('should create user with provided email and password', () async {
      when(mockLoginService.createUserWithEmailAndPassword(
        name: displayName,
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUser);

      final user = await loginRepositoryImpl.createUserWithEmailAndPassword(
        name: displayName,
        email: email,
        password: password,
      );
      expect(user.displayName, mockUser.displayName);
    });

    test('should login user with provided email and password', () async {
      when(mockLoginService.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).thenAnswer((_) async => mockUser);

      final user = await loginRepositoryImpl.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      expect(user.uid, mockUser.uid);
    });

    test('should login user with google', () async {
      when(mockLoginService.signInWithGoogle()).thenAnswer((_) async => mockUser);

      final user = await loginRepositoryImpl.signInWithGoogle();
      expect(user.uid, mockUser.uid);
    });

    test('should login user with facebook', () async {
      when(mockLoginService.loginWithFacebook()).thenAnswer((_) async => mockUser);

      final user = await loginRepositoryImpl.loginWithFacebook();
      expect(user.uid, mockUser.uid);
    });
  });
}
