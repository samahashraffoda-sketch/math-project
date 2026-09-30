import 'package:flutter/material.dart';
import 'package:flutter_application_1/busniess-login/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:flutter_application_1/constant/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  PhoneAuthCubit phoneAuthCubit =PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Container(
      child :BlocProvider(
        create: (context)=> PhoneAuthCubit(),
        
      child: ElevatedButton(
      onPressed: () async{
       await phoneAuthCubit.logOut();
       Navigator.of(context).pushReplacementNamed(loginScreen);
      },
      // ignore: sort_child_properties_last
      child: Text( 
        'Verify',
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
      ),
    );
  }
}