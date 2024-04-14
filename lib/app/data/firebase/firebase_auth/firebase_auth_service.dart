import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> singUpWithEmailAndPassword(
      String email, String passWord) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: passWord);
      return credential.user;
    } catch (e) {
      debugPrint('Đã xảy ra một số lỗi');
    }
    return null;
  }

  Future<User?> singInWithEmailAndPassword(
      String email, String passWord) async {
    try {
      UserCredential? credential = await _auth.signInWithEmailAndPassword(
          email: email, password: passWord);
      return credential.user;
    } catch (e) {
      debugPrint('Đã xảy ra một số lỗi');
    }
    return null;
  }
}
