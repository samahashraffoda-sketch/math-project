import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presention/screens/loginScreen.dart';
import 'package:flutter_application_1/Presention/screens/otp_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'loginScreen':
        return MaterialPageRoute(
          builder: (_) =>  Loginscreen(),
        );
        
        case 'OtpScreen':
        return MaterialPageRoute(
          builder: (_) =>  OtpScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>  Loginscreen(),
        );
    }
  }
}