import 'package:firebase_auth/firebase_auth.dart';
import 'package:studify/helper/helper_functions.dart';
import 'package:studify/service/database_service.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future signInUserWithEmailandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //register
  Future registerUserWithEmailandPassword(
      String name, String email, String password) async {
    try {
      print("password $password");
      print("email, $email");
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // call database service to update userData
      await DatabaseService(uid: user.uid).updateUserData(name, email);
      return true;
    } on FirebaseAuthException catch (e) {
      // print(e);
      return e.message;
    }
  }

  // signOut
  Future userSignOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserEmailSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
