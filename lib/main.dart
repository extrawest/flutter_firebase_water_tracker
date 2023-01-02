import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:water_tracker_app/firebase_options.dart';

import 'app.dart';

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

  runApp(const WaterTrackerApp());
}
