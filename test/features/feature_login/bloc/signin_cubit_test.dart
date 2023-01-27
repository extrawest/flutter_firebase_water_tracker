import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:water_tracker_app/features/feature_login/repositories/login_repository.dart';
import 'package:water_tracker_app/features/feature_login/screens/signin_screen/signin_cubit.dart';
import 'package:water_tracker_app/features/feature_login/screens/signin_screen/signin_state.dart';

import 'signin_cubit_test.mocks.dart';

@GenerateMocks([LoginRepositoryImpl])
void main() {
  group('SignInCubit', () {
    blocTest(
      'should emit [SignInState(isPasswordObscured: false)] when togglePasswordObscure is called',
      build: () => SignInCubit(loginRepository: MockLoginRepositoryImpl()),
      act: (cubit) => cubit.togglePasswordObscure(),
      expect: () => [const SignInState(isPasswordObscured: false)],
    );
    blocTest(
      'should emit [SignInState(isPasswordObscured: true)] when togglePasswordObscure is called twice',
      build: () => SignInCubit(loginRepository: MockLoginRepositoryImpl()),
      act: (cubit) {
        cubit.togglePasswordObscure();
        cubit.togglePasswordObscure();
      },
      expect: () => [
        const SignInState(isPasswordObscured: false),
        const SignInState(isPasswordObscured: true)
      ],
    );
    blocTest(
      'should emit [SignInState(isSignedIn: true)] when onLoginPressed is called',
      build: () {
        final mockLoginRepository = MockLoginRepositoryImpl();
        when(mockLoginRepository.signInWithEmailAndPassword(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenAnswer((_) async => MockUser());
        return SignInCubit(loginRepository: mockLoginRepository);
      },
      act: (cubit) => cubit.onLoginPressed(),
      expect: () => [const SignInState(isSignedIn: true)],
    );
    blocTest(
      'should emit [SignInState(isSignedIn: true)] when onGoogleLoginPressed is called',
      build: () {
        final mockLoginRepository = MockLoginRepositoryImpl();
        when(mockLoginRepository.signInWithGoogle())
            .thenAnswer((_) async => MockUser());
        return SignInCubit(loginRepository: mockLoginRepository);
      },
      act: (cubit) => cubit.onGoogleLoginPressed(),
      expect: () => [const SignInState(isSignedIn: true)],
    );
    blocTest(
      'should emit [SignInState(isSignedIn: true)] when onFacebookLoginPressed is called',
      build: () {
        final mockLoginRepository = MockLoginRepositoryImpl();
        when(mockLoginRepository.loginWithFacebook())
            .thenAnswer((_) async => MockUser());
        return SignInCubit(loginRepository: mockLoginRepository);
      },
      act: (cubit) => cubit.onFacebookLoginPressed(),
      expect: () => [const SignInState(isSignedIn: true)],
    );
    blocTest(
      'should emit [SignInState(isSignedIn: false, error: "Error")] when Login is called with invalid credentials',
      build: () {
        final mockLoginRepository = MockLoginRepositoryImpl();
        when(mockLoginRepository.signInWithEmailAndPassword(
                email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow('Error');
        return SignInCubit(loginRepository: mockLoginRepository);
      },
      act: (cubit) => cubit.onLoginPressed(),
      expect: () => [const SignInState(isSignedIn: false, error: 'Error')],
    );
    blocTest(
      'should emit [SignInState(email: "email", password: "pasword")] when onEmailChanged and onPasswordChanged is called',
      build: () => SignInCubit(loginRepository: MockLoginRepositoryImpl()),
      act: (cubit) {
        cubit.onEmailChanged('email');
        cubit.onPasswordChanged('password');
      },
      expect: () => [
        const SignInState(email: 'email'),
        const SignInState(email: 'email', password: 'password'),
      ],
    );
  });
}
