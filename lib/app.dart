import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/common/ui/theme/theme.dart';
import 'package:water_tracker_app/features/feature_login/repositories/login_repository.dart';
import 'package:water_tracker_app/features/feature_login/services/login_service.dart';

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LoginRepositoryImpl(
            loginService: LoginServiceImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Water Tracker',
        theme: applicationTheme,
        initialRoute: signInScreenRoute,
        routes: applicationRoutes,
      ),
    );
  }
}