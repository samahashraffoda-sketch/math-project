import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

    late final  phoneNumber;

  Widget _buildIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
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
                color: Colors.lightBlue,
                fontSize: 18,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: phoneNumber,
                  style: const TextStyle(
                    color: Colors.black,
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
    return  

MaterialPinField(
  length: 6,
  keyboardType: TextInputType.number,
  onCompleted: (pin) { 
    print(pin);
    },
  onChanged: (value){
    print(value);
  },
  theme: MaterialPinTheme(
  // Shape
  shape: MaterialPinShape.outlined,
  cellSize: Size(56, 64),
  spacing: 8,
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
  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  textGradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
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

  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text("Verify"),
      ),
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
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}