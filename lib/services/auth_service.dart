import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String?> userSignUp(String? email, String? password,
      {String? status, String? company, bool? isAdmin}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        print("SUCCESS REG");
      });
    } on FirebaseAuthException catch (e) {
      return e.message;
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // } else {
      //   print(e.message);
      // }
    } catch (e) {
      return "Something went wrong, Please try again";
    }
    return "ok";
  }

  Future<String?> userSignIn(String? email, String? password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Something went wrong, Please try again";
    }
    return "ok";
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}
