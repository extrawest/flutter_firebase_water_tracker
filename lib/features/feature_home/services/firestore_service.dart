import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirestoreService {
  Future<bool> checkIfDocumentExists({required String path});

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  });

  Future<void> setUserDocument({
    required Map<String, dynamic> data,
  });

  Stream<T> documentStream<T>({
    required String path,
    required T Function(DocumentSnapshot<Map<String, dynamic>>, SnapshotOptions?) fromFirestore,
    required Map<String, Object?> Function(dynamic, SetOptions?) toFirestore,
  });
}

class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<bool> checkIfDocumentExists({required String path}) async {
    final document = await _firestore.doc(path).get();
    return document.exists;
  }

  @override
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    await reference.set(data, SetOptions(merge: merge));
  }

  @override
  Future<void> setUserDocument({
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(
        'users/${FirebaseAuth.instance.currentUser!.uid}');
    _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(reference);
      if (!snapshot.exists) {
        transaction.set(reference, data);
        FirebaseMessaging.instance.subscribeToTopic('reminder');
      }
    });
  }

  @override
  Stream<T> documentStream<T>({
    required String path,
    required T Function(DocumentSnapshot<Map<String, dynamic>>, SnapshotOptions?) fromFirestore,
    required Map<String, Object?> Function(dynamic, SetOptions?) toFirestore,
  }) {
    final reference = _firestore.doc(path).withConverter(
      fromFirestore: fromFirestore,
      toFirestore: toFirestore,
    );
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.data()!);
  }
}
