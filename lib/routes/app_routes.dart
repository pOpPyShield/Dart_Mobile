import 'package:flutter/material.dart';
import 'package:volunteerapp/presentation/splash_screen/splash_screen.dart';
import 'package:volunteerapp/presentation/onbroading_screen_one_screen/onbroading_screen_one_screen.dart';
import 'package:volunteerapp/presentation/onbroading_screen_two_screen/onbroading_screen_two_screen.dart';
import 'package:volunteerapp/presentation/onbroading_screen/onbroading_screen.dart';
import 'package:volunteerapp/presentation/signup_screen/signup_screen.dart';
import 'package:volunteerapp/presentation/login_screen/login_screen.dart';
import 'package:volunteerapp/presentation/bottomnavigation_screen/bottomnavigation_screen.dart';
import 'package:volunteerapp/presentation/paymethod_screen/paymethod_screen.dart';
import 'package:volunteerapp/presentation/explore_screen/explore_screen.dart';
import 'package:volunteerapp/presentation/activity_screen/activity_screen.dart';
import 'package:volunteerapp/presentation/profile_screen/profile_screen.dart';
import 'package:volunteerapp/presentation/editprofile_screen/editprofile_screen.dart';
import 'package:volunteerapp/presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String onbroadingScreenOneScreen =
      '/onbroading_screen_one_screen';

  static const String onbroadingScreenTwoScreen =
      '/onbroading_screen_two_screen';

  static const String onbroadingScreen = '/onbroading_screen';

  static const String signupScreen = '/signup_screen';

  static const String loginScreen = '/login_screen';

  static const String tabviewPage = '/tabview_page';

  static const String homeScreenPage = '/home_screen_page';

  static const String bottomnavigationScreen = '/bottomnavigation_screen';

  static const String detailScreen = '/detail_screen';

  static const String paymethodScreen = '/paymethod_screen';

  static const String exploreScreen = '/explore_screen';

  static const String activityScreen = '/activity_screen';

  static const String profileScreen = '/profile_screen';

  static const String editprofileScreen = '/editprofile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    onbroadingScreenOneScreen: (context) => OnbroadingScreenOneScreen(),
    onbroadingScreenTwoScreen: (context) => OnbroadingScreenTwoScreen(),
    onbroadingScreen: (context) => OnbroadingScreen(),
    signupScreen: (context) => SignupScreen(),
    loginScreen: (context) => LoginScreen(),
    bottomnavigationScreen: (context) => BottomnavigationScreen(),
    exploreScreen: (context) => ExploreScreen(),
    activityScreen: (context) => ActivityScreen(),
    profileScreen: (context) => ProfileScreen(),
    editprofileScreen: (context) => EditprofileScreen(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}
