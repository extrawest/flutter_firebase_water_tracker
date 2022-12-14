import 'package:firebase_auth/firebase_auth.dart';

import '../services/login_service.dart';

abstract class LoginRepository {
  final LoginService loginService;

  const LoginRepository({
    required this.loginService,
  });

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  final LoginService loginService;

  const LoginRepositoryImpl({
    required this.loginService,
  });

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await loginService.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
