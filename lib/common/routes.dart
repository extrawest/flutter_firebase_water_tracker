import 'package:flutter/cupertino.dart';
import 'package:water_tracker_app/common/ui/screens/splash_screen.dart';
import 'package:water_tracker_app/features/feature_home/screens/home_screen/home_screen.dart';

import '../features/feature_login/screens/signin_screen/signin_screen.dart';
import '../features/feature_login/screens/signup_screen/singup_screen.dart';

const splashScreenRoute = 'splash_screen';
const signInScreenRoute = 'signIn_screen';
const signUpScreenRoute = 'signUp_screen';
const homeScreenRoute = 'home_screen';

final applicationRoutes = <String, WidgetBuilder>{
  splashScreenRoute: (BuildContext context) => const SplashScreen(),
  signInScreenRoute: (BuildContext context) => const SignInScreen(),
  signUpScreenRoute: (BuildContext context) => const SignUpScreen(),
  homeScreenRoute: (BuildContext context) => const HomeScreen(),
};