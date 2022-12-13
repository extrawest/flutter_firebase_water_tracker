import 'package:flutter/cupertino.dart';
import 'package:water_tracker_app/common/ui/screens/splash_screen.dart';

import '../features/feature_login/screens/signin_screen.dart';

const splashScreenRoute = 'splash_screen';
const signInScreenRoute = 'signIn_screen';

final applicationRoutes = <String, WidgetBuilder>{
  'splash_screen': (BuildContext context) => const SplashScreen(),
  'signIn_screen': (BuildContext context) => const SignInScreen(),
};