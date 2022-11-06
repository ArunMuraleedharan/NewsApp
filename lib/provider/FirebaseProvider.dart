
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthenticationService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();



  Future<String> signIn({required String email, required String password}) async {
    try {

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Signup Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}

