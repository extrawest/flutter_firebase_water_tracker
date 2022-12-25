import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirestoreService {
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  });

  Stream<Map<String, dynamic>> documentStream({
    required String path,
  });
}

class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    print('$path: $data');
    await reference.set(data, SetOptions(merge: merge));
  }

  @override
  Stream<Map<String, dynamic>> documentStream({
    required String path,
  }) {
    final reference = _firestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.data() as Map<String, dynamic>);
  }
}
