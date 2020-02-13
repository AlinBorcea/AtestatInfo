import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> isLoggedIn() async {
  return await _auth.currentUser() != null;
}

Future<bool> registerUser(String email, String password) async {
  final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password))
      .user;

  return user != null;
}
