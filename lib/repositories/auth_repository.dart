import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthRepository {
  Future<dynamic> registerUser(String email, String password) async {
    final user = await _firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }
}
