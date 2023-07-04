import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthRepository {
  Future<dynamic> registerUser(String email, String password) async {
    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredentials;
    } catch (error) {
      return 'ERROR: $error';
    }
  }
}
