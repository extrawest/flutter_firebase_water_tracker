import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/login_repository.dart';
import 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginRepository loginRepository;

  SignInCubit({required this.loginRepository}) : super(const SignInState());

  void togglePasswordObscure() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> onLoginPressed() async {
    try {
      await loginRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isSignedIn: true));
    }
    catch (error, stackTrace) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: error.toString()));
      });
      loginRepository.recordError(error.toString(), stackTrace, reason: 'Login Error');
    }
  }

  Future<void> onGoogleLoginPressed() async {
    try {
      await loginRepository.signInWithGoogle();
      emit(state.copyWith(isSignedIn: true));
    }
    catch (error, stackTrace) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: ''));
      });
      loginRepository.recordError(error.toString(), stackTrace, reason: 'Login Error');
    }
  }

  Future<void> onFacebookLoginPressed() async {
    try {
      await loginRepository.loginWithFacebook();
      emit(state.copyWith(isSignedIn: true));
    }
    catch (error, stackTrace) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: ''));
      });
      loginRepository.recordError(error.toString(), stackTrace, reason: 'Login Error');
    }
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }
}