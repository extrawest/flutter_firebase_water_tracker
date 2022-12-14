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

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithGoogle();

  Future<User> loginWithFacebook();
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

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await loginService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<User> signInWithGoogle() async {
    return await loginService.signInWithGoogle();
  }

  @override
  Future<User> loginWithFacebook() async {
    return await loginService.loginWithFacebook();
  }
}
