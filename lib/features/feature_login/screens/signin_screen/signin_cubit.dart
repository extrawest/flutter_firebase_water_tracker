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
    final user = await loginRepository.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    print(user);
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }
}