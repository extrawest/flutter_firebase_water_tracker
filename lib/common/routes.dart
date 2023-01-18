import 'package:flutter/material.dart';
import 'package:water_tracker_app/common/ui/screens/splash_screen.dart';
import 'package:water_tracker_app/features/feature_home/screens/account_screen/account_screen.dart';
import 'package:water_tracker_app/features/feature_home/screens/home_screen.dart';
import 'package:water_tracker_app/features/feature_home/widgets/daily_goal_view.dart';
import 'package:water_tracker_app/features/feature_home/widgets/drinks_list_view.dart';

import '../features/feature_login/screens/signin_screen/signin_screen.dart';
import '../features/feature_login/screens/signup_screen/singup_screen.dart';

const splashScreenRoute = 'splash_screen';
const signInScreenRoute = 'signIn_screen';
const signUpScreenRoute = 'signUp_screen';
const homeScreenRoute = 'home_screen';
const accountScreenRoute = 'account_screen';
const dailyGoalScreenRoute = 'daily_goal_screen';
const drinksListScreenRoute = 'drinks_list_screen';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case signInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case accountScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const AccountScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
  }
}

Route<dynamic> onGenerateRouteNested(RouteSettings settings) {
  switch (settings.name) {
    case dailyGoalScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DailyGoalView(),
      );
    case drinksListScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const DrinksListView(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const DailyGoalView(),
      );
  }
}
