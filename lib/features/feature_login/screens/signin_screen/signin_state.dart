import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordObscured;
  final String error;
  final bool isSignedIn;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordObscured = true,
    this.error = '',
    this.isSignedIn = false,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordObscured,
    String? error,
    bool? isSignedIn,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      error: error ?? this.error,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordObscured,
        email,
        password,
        error,
        isSignedIn,
      ];
}
