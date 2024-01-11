import 'package:flutter/material.dart';
import 'package:volunteerapp/core/app_export.dart';
import 'package:volunteerapp/presentation/activity_screen/activity_screen.dart';
import 'package:volunteerapp/presentation/explore_screen/explore_screen.dart';
import 'package:volunteerapp/presentation/home_screen_page/home_screen_page.dart';
import 'package:volunteerapp/presentation/login_screen/login_screen.dart';
import 'package:volunteerapp/presentation/profile_screen/profile_screen.dart';
import 'package:volunteerapp/widgets/custom_bottom_bar.dart';

// ignore_for_file: must_be_immutable
class BottomnavigationScreen extends StatefulWidget {
  BottomnavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomnavigationScreenState createState() => _BottomnavigationScreenState();
}

class _BottomnavigationScreenState extends State<BottomnavigationScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool isBottomBarVisible = true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.homeScreenPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: isBottomBarVisible
            ? _buildBottomBar(context)
            : SizedBox
                .shrink(), // Hide BottomNavigationBar when isBottomBarVisible is false
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  /// Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.User:
        return AppRoutes.homeScreenPage;
      case BottomBarEnum.Thumbsup:
        return AppRoutes.activityScreen;
      case BottomBarEnum.Clock:
        return AppRoutes.exploreScreen;
      case BottomBarEnum.Lock:
        return AppRoutes.profileScreen;
      default:
        return "/";
    }
  }

  /// Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeScreenPage:
        return HomeScreenPage();
      case AppRoutes.activityScreen:
        return ActivityScreen();
      case AppRoutes.exploreScreen:
        return ExploreScreen();
      case AppRoutes.profileScreen:
        return ProfileScreen(
          onLogoutPressed: () {
            setState(() {
              isBottomBarVisible = false;
              Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
            });
          },
        );
      default:
        return DefaultWidget();
    }
  }
}
