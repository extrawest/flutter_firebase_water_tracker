import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class LoginServiceImpl implements LoginService {
  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!;
  }
}