// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthRepository {
  Future<dynamic> registerUser(String email, String password) async {
    try {
      final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredentials;
    } on FirebaseAuthException catch (error) {
      return 'ERROR: ${error.message}';
    }
  }

  Future<User?> logInUser(String email, String password) async {
    try {
      final UserCredential userCredentials = await _firebase
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredentials.user;
    } on FirebaseAuthException catch (error) {
      throw FirebaseAuthException(code: error.code, message: error.message);
    } catch (error) {
      print(error);
    }
    return null;
  }
}
