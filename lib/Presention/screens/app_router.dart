import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presention/screens/loginScreen.dart';
import 'package:flutter_application_1/Presention/screens/map_screen.dart';
import 'package:flutter_application_1/Presention/screens/otp_screen.dart';
import 'package:flutter_application_1/busniess-login/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_application_1/constant/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  // ignore: body_might_complete_normally_nullable

  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case mapScreen:
        return MaterialPageRoute(
          builder: (_) =>  MapScreen(),
        );
 
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
            value: phoneAuthCubit!,
            child: Loginscreen()  ,
          ),
        );
        
        case 'otpScreen':
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) =>  BlocProvider.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber) ,
          ),
        );
    }
    return null;
  }
}