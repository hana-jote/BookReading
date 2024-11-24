import 'package:thboooks/Screens/Loading/loadng.dart';
import 'package:thboooks/Screens/Login/loginform.dart';
import 'package:thboooks/Screens/Profile/profilepage.dart';
import 'package:thboooks/Screens/Settings/Settings.dart';
import 'package:thboooks/Screens/Signup/signupform.dart';
import 'package:thboooks/Screens/Todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:thboooks/Screens/Upload/upload.dart';

class RouteManager {
  static const String loginPage = '/';
  static const String uploadfile = '/uploadbook';
  static const String updateprofile = '/updateprofile';
  static const String registerPage = '/registerPage';
  static const String todoPage = '/todoPage';
  static const String loadingPage = '/loadingPage';
  static const String settingpage = '/Settings';
  static const String profilepage = '/profilepage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case uploadfile:
        return MaterialPageRoute(builder: (context) => UploadScreen());
      case profilepage:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case settingpage:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => const Login(),
        );

      case registerPage:
        return MaterialPageRoute(
          builder: (context) => const Register(),
        );

      case todoPage:
        return MaterialPageRoute(
          builder: (context) => const TodoPage(),
        );

      case loadingPage:
        return MaterialPageRoute(
          builder: (context) => const Loading(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
