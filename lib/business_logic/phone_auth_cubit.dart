import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationID;
  PhoneAuthCubit() : super(PhoneAuthInitial());
  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }
  void verificationCompleted(PhoneAuthCredential credential)async{
    print('verification completed');
    await signIn(credential);
  }

  void verificationFailed(FirebaseException exception){
    print('verificationFailed $exception.toString()');
    emit(ErrorOccurred(exception.toString()));
  }
  void codeSent(String verificationID, int? resendToken){ //TODO Implement resend code functionality from firebase docs
    print('codeSent');
    this.verificationID=verificationID;
    emit(PhoneNumberSubmitted());
  }
  void codeAutoRetrievalTimeout(StringverificationID){
    print('codeAutoRetrievalTimeout');
  }
  Future<void> submitOTP(String otpCode)async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpCode);
    await signIn(credential);
  }
  Future<void>signIn(PhoneAuthCredential credential)async{
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch(error){
      emit(ErrorOccurred(error.toString()));
    }
  }
  Future<void> logOut()async{
    await FirebaseAuth.instance.signOut();
  }
  User getLoggedInUser(){
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
