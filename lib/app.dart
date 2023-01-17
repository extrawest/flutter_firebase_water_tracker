import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/common/ui/theme/theme.dart';
import 'package:water_tracker_app/features/feature_home/repositories/account_repository.dart';
import 'package:water_tracker_app/features/feature_home/repositories/home_repository.dart';
import 'package:water_tracker_app/features/feature_home/services/account_service.dart';
import 'package:water_tracker_app/features/feature_login/repositories/login_repository.dart';
import 'package:water_tracker_app/features/feature_login/services/login_service.dart';

import 'features/feature_home/services/dynamic_links_service.dart';
import 'features/feature_home/services/firebase_config_service.dart';
import 'features/feature_home/services/firebase_crashlytics_service.dart';
import 'features/feature_home/services/firestore_service.dart';

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepositoryImpl(
            loginService: LoginServiceImpl(),
            fireStoreService: FirestoreServiceImpl(),
            firebaseCrashlyticsService: FirebaseCrashlyticsServiceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => HomeRepositoryImpl(
            firestoreService: FirestoreServiceImpl(),
            firebaseConfigService: FirebaseConfigServiceImpl(),
            dynamicLinksService: DynamicLinksServiceImpl(),
            firebaseCrashlyticsService: FirebaseCrashlyticsServiceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AccountRepositoryImpl(
            accountService: AccountServiceImpl(),
            dynamicLinkService: DynamicLinksServiceImpl(),
            firebaseCrashlyticsService: FirebaseCrashlyticsServiceImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Water Tracker',
        theme: applicationTheme,
        initialRoute: splashScreenRoute,
        routes: applicationRoutes,
      ),
    );
  }
}
