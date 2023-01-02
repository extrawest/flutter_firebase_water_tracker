import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

abstract class AccountService {
  Stream<UserModel> getUser();
}

class AccountServiceImpl implements AccountService {
  @override
  Stream<UserModel> getUser() {
    final db = FirebaseFirestore.instance;
    final uuid = FirebaseAuth.instance.currentUser!.uid;
    return db
        .collection('users')
        .doc(uuid)
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }
}
