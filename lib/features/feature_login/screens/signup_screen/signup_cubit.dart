import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/login_repository.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final LoginRepository loginRepository;

  SignUpCubit({required this.loginRepository}) : super(const SignUpState());

  void togglePasswordObscure() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  Future<void> onRegisterButtonPressed() async {
    final user = await loginRepository.createUserWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    print(user);
  }

  void onNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void onEmailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void onPasswordChanged(String value) {
    emit(state.copyWith(password: value));
  }

  void onConfirmPasswordChanged(String value) {
    emit(state.copyWith(confirmPassword: value));
  }
}
