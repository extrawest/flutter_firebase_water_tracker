import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordObscured;
  final String error;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordObscured = true,
    this.error = '',
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordObscured,
    String? error,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured, email, password, error];
}