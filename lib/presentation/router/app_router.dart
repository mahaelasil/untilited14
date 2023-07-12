import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/user_screen.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings){
    startScreen = const UsersScreen();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case usersScreen:
        return MaterialPageRoute(builder: (_) => const UsersScreen());
      case homeScreen:
        final Map data = settings.arguments as Map;
        final String myName = data['name'];
        final String myPassword = data['password'];
        if (kDebugMode) {
          print(myPassword);
        }
        return MaterialPageRoute(builder: (_) => HomeScreen(myName: myName,));
      default:
        return null;
    }
  }
}