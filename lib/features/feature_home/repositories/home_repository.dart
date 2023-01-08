import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_tracker_app/features/feature_home/services/dynamic_links_service.dart';

import '../models/drink_model.dart';
import '../services/firebase_config_service.dart';
import '../services/firestore_service.dart';

abstract class HomeRepository {
  Future<String> getProgressIndicatorType();

  Future<void> addDrink({required String drinkName, required int drinkAmount});

  Stream<Map<String, dynamic>> userStream();

  Stream<List<Drink>> drinksStream();

  Future<void> handleDynamicLink(void Function(int) callback);
}

class HomeRepositoryImpl implements HomeRepository {
  final auth = FirebaseAuth.instance;
  final FirestoreService firestoreService;
  final FirebaseConfigService firebaseConfigService;
  final DynamicLinksService dynamicLinksService;

  HomeRepositoryImpl({
    required this.firestoreService,
    required this.firebaseConfigService,
    required this.dynamicLinksService,
  });

  @override
  Future<String> getProgressIndicatorType() async {
    await firebaseConfigService.initialize();
    return firebaseConfigService.progressIndicatorType;
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
    await FirebaseAnalytics.instance.logEvent(
      name: 'drink_added',
      parameters: {'amount': drinkAmount},
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
    return firestoreService
        .documentStream(
      path: 'users/${auth.currentUser!.uid}/days/$dateTimestamp',
    )
        .map((snapshot) {
      final drinks = snapshot['drinks'] as List<dynamic>;
      return drinks.map((drink) => Drink.fromMap(drink)).toList();
    });
  }

  @override
  Future<void> handleDynamicLink(void Function(int) callback) async {
    dynamicLinksService.handleDynamicLink(callback);
  }
}
