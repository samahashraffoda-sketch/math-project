
import 'package:flutter/material.dart';
import 'package:flutter_application_1/busniess-login/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_application_1/constant/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final phoneNumber;
  OtpScreen({super.key, this.phoneNumber});

  late String otpCode;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter your 6 digit code numbers sent to ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPinCodeFields() {
    return MaterialPinField(
      length: 6,
      keyboardType: TextInputType.number,
      onCompleted: (code) {
        otpCode = code;
        print("otpcode");
      },
      onChanged: (value) {
        print('value');
      },
      theme: MaterialPinTheme(
        // Shape
        shape: MaterialPinShape.outlined,
        cellSize: Size(45, 60),
        spacing: 6,
        borderRadius: BorderRadius.circular(12),

        // Border
        borderWidth: 1.5,
        focusedBorderWidth: 2.0,
        borderColor: Colors.grey,
        focusedBorderColor: Colors.blue,
        filledBorderColor: Colors.green,
        errorColor: Colors.red,

        // Fill
        fillColor: Colors.grey[100],
        focusedFillColor: Colors.blue[50],
        filledFillColor: Colors.green[50],

        // Text
        textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textGradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
        ),
        obscuringCharacter: '●',

        // Cursor
        showCursor: true,
        cursorColor: Colors.blue,
        cursorWidth: 2,
        animateCursor: true,

        // Animation
        entryAnimation: MaterialPinAnimation.scale,
        animationDuration: Duration(milliseconds: 150),
        animationCurve: Curves.easeOut,

        // Error
        enableErrorShake: true,
        errorAnimationDuration: Duration(milliseconds: 500),
      ),
    );
      
  }
  

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOtp(otpCode);
  }

  Widget _buildVerifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          showProgressIndicator(context);
          _login(context);
        },
        // ignore: sort_child_properties_last
        child: Text(
          'Verify',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          maximumSize: Size(110, 50),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  void showProgressIndicator(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      ),
    );

    showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  // ignore: unused_element
  Widget _buildPhoneNumberSubmitedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        // Determine when to listen to state changes
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }
      },
    );
  }

  Widget _buildPhoneVerificationBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        // Determine when to listen to state changes
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is PhoneOtpVerified) {
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(mapScreen);
        }

        if (state is ErrorOccured) {
          Navigator.pop(context);
          String errorMessage = (state).errorMessage;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 40,
          ),
          child: Column(
            children: [
              _buildIntroTexts(),
              const SizedBox(height: 70),
              _buildPinCodeFields(),
              const SizedBox(height: 70),
              _buildVerifyButton(context),
              _buildPhoneVerificationBloc(),
            ],
          ),
        ),
      ),
    );
  }
}


