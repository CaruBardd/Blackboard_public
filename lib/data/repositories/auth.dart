import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:red_blackboard/domain/repositorires/auth.dart';

class Auth implements AuthInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override //logiar
  Future<bool> signIn({required String email, required String password}) async {
    /*final emailVal = "blackboard@uninorte.co" == email;
    final passwordVal = "1234567" == password;
    return emailVal && passwordVal;*/
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
         if (user.user != null) {
        print('login success');
        return true;
      }
      print('credenciales no validas');
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return false;
    }
  }

  @override // deslogiar
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override // no se uso
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final emailVal = email.contains("@") && email.contains(".co");
    final passwordVal = password.length > 6;

    return emailVal && passwordVal;
  }
}
