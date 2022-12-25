import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/drink_model.dart';
import '../services/firestore_service.dart';

abstract class HomeRepository {
  Future<void> updateUser();

  Future<void> addDrink({required String drinkName, required int drinkAmount});

  Stream<Map<String, dynamic>> userStream();

  Stream<List<Drink>> drinksStream();
}

class HomeRepositoryImpl implements HomeRepository {
  final auth = FirebaseAuth.instance;
  final FirestoreService firestoreService;

  HomeRepositoryImpl({required this.firestoreService});

  @override
  Future<void> updateUser() async {
    await firestoreService.setData(
      path: 'users/${auth.currentUser!.uid}',
      data: {
        'name': auth.currentUser!.displayName,
        'email': auth.currentUser!.email,
        'photo_url': auth.currentUser!.photoURL,
        'daily_goal': 4000,
      },
    );
  }

  @override
  Future<void> addDrink({
    required String drinkName,
    required int drinkAmount,
  }) async {
    final dateTimestamp = Timestamp.now().toDate().toString().split(' ')[0];
    final drinkTimestamp = Timestamp.now().toDate().toString().split(' ')[1];
    await firestoreService.setData(
      merge: true,
      path: 'users/${auth.currentUser!.uid}/days/$dateTimestamp',
      data: {
        'drinks': FieldValue.arrayUnion([
          {
            'name': drinkName,
            'amount': drinkAmount,
            'timestamp': drinkTimestamp,
          }
        ]),
      },
    );
  }

  @override
  Stream<Map<String, dynamic>> userStream() {
    return firestoreService.documentStream(
      path: 'users/${auth.currentUser!.uid}',
    );
  }

  @override
  Stream<List<Drink>> drinksStream() {
    final dateTimestamp = Timestamp.now().toDate().toString().split(' ')[0];
    return firestoreService.documentStream(
      path: 'users/${auth.currentUser!.uid}/days/$dateTimestamp',
    ).map((snapshot) {
      final drinks = snapshot['drinks'] as List<dynamic>;
      return drinks.map((drink) => Drink.fromMap(drink)).toList();
    });
  }
}
