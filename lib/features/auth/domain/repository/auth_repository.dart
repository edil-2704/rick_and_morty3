import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential?> signUp(
      {required String email, required String password});

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  });
}
