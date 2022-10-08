import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  static Future<String> userLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'successfully Login';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'user not registered';
      } else if (e.code == 'wrong-password') {
        return 'wrong password';
      } else if (e.code == 'invalid-email') {
        return 'invalid email';
      } else {
        return 'no internet connection';
      }
    }
  }

  static Future<String> userSignup(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseAuth.instance.signOut();
      });
      // userCredential.user.
      //signout the user when signup
      //await FirebaseAuth.instance.signOut();
      return 'Successfuly signUp';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'weak password';
      } else if (e.code == 'email-already-in-use') {
        return 'user already registered';
      } else if (e.code == 'invalid-email') {
        return 'invalid email';
      } else {
        return 'No Internet Connection';
      }
    }
  }

  static Future adminLogin(String email, String password) async {
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc('adminLogin')
          .snapshots()
          .forEach((element) {
        if (element.data()!['email'] == email &&
            element.data()!['password'] == password) {}
      });
    } catch (e) {}
  }
}
