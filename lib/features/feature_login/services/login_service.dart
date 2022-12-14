import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginService {
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<User> signInWithGoogle();
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

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user!;
  }

  @override
  Future<User> signInWithGoogle() async {
    if (kIsWeb) {
      final googleProvider = GoogleAuthProvider();

      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      final userCred =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      return userCred.user!;
    } else {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCred.user!;
    }
  }
}
