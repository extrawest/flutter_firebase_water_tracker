import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final bool isPasswordObscured;

  const SignInState({
    this.isPasswordObscured = true,
  });

  SignInState copyWith({
    bool? isPasswordObscured,
  }) {
    return SignInState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured];
}