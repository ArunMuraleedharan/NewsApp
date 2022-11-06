import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier
{
  final googlesignin=GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user =>_user!;

   Future googleLogin() async
  {
    final googleuser=await googlesignin.signIn();
    if(googleuser==null) return;
    _user=googleuser;

     final googleauth=await googleuser.authentication;

     final credential=GoogleAuthProvider.credential(
       accessToken: googleauth.accessToken,
       idToken: googleauth.idToken
     );

     await FirebaseAuth.instance.signInWithCredential(credential);

     notifyListeners();
  }
}