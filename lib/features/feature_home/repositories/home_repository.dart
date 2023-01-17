import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:water_tracker_app/features/feature_home/services/dynamic_links_service.dart';

import '../models/drink_model.dart';
import '../models/user_model.dart';
import '../services/firebase_config_service.dart';
import '../services/firebase_crashlytics_service.dart';
import '../services/firestore_service.dart';

abstract class HomeRepository {
  Future<String> getProgressIndicatorType();

  Future<bool> addDrink({required String drinkName, required int drinkAmount});

  Stream<UserModel> userStream();

  Stream<List<DrinkModel>> drinksStream();

  Future<void> handleDynamicLink(void Function(int) callback);

  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason});
}

class HomeRepositoryImpl implements HomeRepository {
  final auth = FirebaseAuth.instance;
  final FirestoreService firestoreService;
  final FirebaseConfigService firebaseConfigService;
  final DynamicLinksService dynamicLinksService;
  final FirebaseCrashlyticsService firebaseCrashlyticsService;

  HomeRepositoryImpl({
    required this.firestoreService,
    required this.firebaseConfigService,
    required this.dynamicLinksService,
    required this.firebaseCrashlyticsService,
  });

  @override
  Future<String> getProgressIndicatorType() async {
    await firebaseConfigService.initialize();
    return firebaseConfigService.progressIndicatorType;
  }

  @override
  Future<bool> addDrink({
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
    return true;
  }

  @override
  Stream<UserModel> userStream() {
    return firestoreService.documentStream(
      path: 'users/${auth.currentUser!.uid}',
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
  }

  @override
  Stream<List<DrinkModel>> drinksStream() {
    final dateTimestamp = Timestamp.now().toDate().toString().split(' ')[0];
    return firestoreService
        .documentStream(
      path: 'users/${auth.currentUser!.uid}/days/$dateTimestamp',
      fromFirestore: (snapshot, _) => (snapshot.data()!['drinks'] as List)
              .map((drink) => DrinkModel.fromJson(drink))
              .toList(),
      toFirestore: (data, _) => data.toMap(),
    );
  }

  @override
  Future<void> handleDynamicLink(void Function(int) callback) async {
    dynamicLinksService.handleDynamicLink(callback);
  }

  @override
  Future<void> recordError(String message, StackTrace stackTrace,
      {dynamic reason}) {
    return firebaseCrashlyticsService.recordError(message, stackTrace, reason: reason);
  }
}
