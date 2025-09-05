import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_to_do_list/data/firestor.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
  Future<void> logout();
}

class AuthenticationRemote extends AuthenticationDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> login(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  @override
  Future<void> register(
      String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      throw FirebaseAuthException(
          code: 'password-mismatch', message: 'Passwords do not match');
    }

    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    )
        .then((value) {
      Firestore_Datasource().CreateUser(email);
    });
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
