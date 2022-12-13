import 'package:flutter/cupertino.dart';
import 'package:water_tracker_app/common/ui/screens/splash_screen.dart';

const splashScreenRoute = 'splash_screen';

final applicationRoutes = <String, WidgetBuilder>{
  'splash_screen': (BuildContext context) => const SplashScreen(),
};