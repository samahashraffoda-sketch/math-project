// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/my_colors.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
   Loginscreen({super.key});
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  late String phoneNumber;

 Widget  _buildIntroTexts(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'What is your phone number?',
      style: TextStyle(
        color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold,
      ),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal:2),
        child: Text(
          'Please enter phone number to verfiy your account !',
           style: TextStyle(
            color: Colors.black,
            fontSize: 16,
           ),
          ),
      ),
    ],
  );
 }
  Widget _buildPhoneFormField(){
   return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.ColorLightBlue),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: Text('${generateCountryFlag()} +20',
             style: TextStyle(fontSize: 18,letterSpacing: 2.0),
            ),
      ),
      ),
      SizedBox(
        width: 16,
      ),

 Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.ColorBlue),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              autofocus: true,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 2.0,
              ),
              decoration: InputDecoration(border: InputBorder.none),
              cursorColor: Colors.black,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty){
                  return 'Plase enter your phone number!';
                } else if (value.length < 11){
                  return 'Too short for a phone number!';
                }
                return null;
              },
              onSaved: (value){
                phoneNumber = value!;
              },
            ),
      ),
      ),
    ],
   );
}
 String generateCountryFlag(){
  String countryCode = 'eg';

  String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'), 
  (match)=>String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

  return flag;
 }

 Widget _buildNextButton(){
   return Align(
     alignment: Alignment.centerRight,
     child: ElevatedButton(
      onPressed: () {},
      // ignore: sort_child_properties_last
      child: Text( 
        'Next',
      style: TextStyle(color:Colors.white, fontSize:16),
           ),
      style: ElevatedButton.styleFrom(
        maximumSize: Size(110, 50),
        backgroundColor:Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      ),
   );
 }
  @override
  Widget build(BuildContext context) {
    return SafeArea (
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key:_phoneFormKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal : 32 ,vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntroTexts(),
                SizedBox(height: 70,),
                _buildPhoneFormField(),
                   SizedBox(height: 50,),
                _buildNextButton(),
              ],
            ),
          ),
          ),
      ),
    );
  }
} 