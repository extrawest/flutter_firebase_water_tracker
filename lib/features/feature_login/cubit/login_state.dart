import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isPasswordObscured;

  const LoginState({
    this.isPasswordObscured = true,
  });

  LoginState copyWith({
    bool? isPasswordObscured,
  }) {
    return LoginState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured];
}