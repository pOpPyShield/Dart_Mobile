import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volunteerapp/theme/theme_helper.dart';
import 'package:volunteerapp/routes/app_routes.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');

  // Check for saved token
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');

  // Run the app with or without the token
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  MyApp({this.token});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'volunteerapp',
      debugShowCheckedModeBanner: false,
      initialRoute: token != null
          ? AppRoutes.bottomnavigationScreen
          : AppRoutes.loginScreen,
      routes: AppRoutes.routes,
    );
  }
}
