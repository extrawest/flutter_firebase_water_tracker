import 'package:flutter/material.dart';
import 'package:water_tracker_app/common/routes.dart';
import 'package:water_tracker_app/common/ui/theme/theme.dart';

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Tracker',
      theme: applicationTheme,
      initialRoute: splashScreenRoute,
      routes: applicationRoutes,
    );
  }
}
