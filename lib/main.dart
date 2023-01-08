import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:water_tracker_app/firebase_options.dart';

import 'app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
    if (firebaseUser != null && firebaseUser.email != null) {
      FirebaseCrashlytics.instance.setCustomKey(
        'email',
        firebaseUser.email ?? '',
      );
    }
    if (firebaseUser != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(firebaseUser.uid);
    }
    if (firebaseUser != null && firebaseUser.displayName != null) {
      FirebaseCrashlytics.instance.setCustomKey(
        'name',
        firebaseUser.displayName ?? '',
      );
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const WaterTrackerApp());
}
