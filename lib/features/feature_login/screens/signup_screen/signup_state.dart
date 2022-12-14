import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool isPasswordObscured;

  const SignUpState({
    this.isPasswordObscured = true,
  });

  SignUpState copyWith({
    bool? isPasswordObscured,
  }) {
    return SignUpState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
    );
  }

  @override
  List<Object?> get props => [isPasswordObscured];
}