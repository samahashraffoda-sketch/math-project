
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {

late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());


  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    
    await FirebaseAuth  .instance.verifyPhoneNumber(
      phoneNumber: '+20$phoneNumber',
      timeout: const Duration(seconds: 20)  ,

      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed ,
      
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
  void verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    emit(ErrorOccured(errorMessage: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    this.verificationId = verificationId;
  }

  Future<void> submitOtp(String otpCode) async {
    emit(Loading());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      // ignore: unnecessary_this
      verificationId: this.verificationId,smsCode: otpCode
       );
    await signIn(credential);
  }
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerified());
    } catch (error) {
      emit(ErrorOccured(errorMessage: error.toString()));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
   
  }
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> logOut() async {}
}