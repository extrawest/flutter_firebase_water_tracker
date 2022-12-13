import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  void togglePasswordObscure() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }
}