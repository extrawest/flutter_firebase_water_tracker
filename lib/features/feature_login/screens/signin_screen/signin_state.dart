import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordObscured;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordObscured = true,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordObscured,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured, email, password];
}