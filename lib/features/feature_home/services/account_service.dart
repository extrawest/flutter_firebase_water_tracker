import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

abstract class AccountService {
  Stream<UserModel> getUser();

  Future<void> uploadPhoto();

  Future<void> signOut();
}

class AccountServiceImpl implements AccountService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  Stream<UserModel> getUser() {
    final uuid = _auth.currentUser!.uid;
    return _db
        .collection('users')
        .doc(uuid)
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  @override
  Future<void> uploadPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      final uuid = _auth.currentUser!.uid;
      final ref = _storage.ref().child('users/$uuid');
      await ref.putFile(file);
      final uploadedImage = await ref.getDownloadURL();
      await _db
          .collection('users')
          .doc(uuid)
          .update({'photo_url': uploadedImage});
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
