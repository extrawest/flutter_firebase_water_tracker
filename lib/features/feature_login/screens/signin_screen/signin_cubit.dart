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
      final user = await loginRepository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      print(user);
    }
    catch (error) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: ''));
      });
    }
  }

  Future<void> onGoogleLoginPressed() async {
    try {
      final user = await loginRepository.signInWithGoogle();
      print(user);
    }
    catch (error) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: ''));
      });
    }
  }

  Future<void> onFacebookLoginPressed() async {
    try {
      final user = await loginRepository.loginWithFacebook();
      print(user);
    }
    catch (error) {
      emit(state.copyWith(error: error.toString()));
      Future.delayed(const Duration(seconds: 5), () {
        emit(state.copyWith(error: ''));
      });
    }
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }
}