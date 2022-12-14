import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordObscured;

  const SignUpState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordObscured = true,
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isPasswordObscured,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordObscured,
        name,
        email,
        password,
        confirmPassword,
      ];
}
