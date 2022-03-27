import 'package:class_project_chat_app/chat_screen/chat_screen_page.dart';
import 'package:class_project_chat_app/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signInWithGoogle(context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount!.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential userCredential =
    await firebaseAuth.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ChatPage()));
    }
  }

  void resister(context, email, password) async {
    try {
      firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (err) {
      showError(context, err);
    }
  }

  void login(context, email, password) async {
    try {
      firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
          MaterialPageRoute(builder: (context) => const ChatPage()));
    } catch (err) {
      showError(context, err);
    }
  }

  void signOut(context) async {
    try {
      firebaseAuth.signOut().then((value) =>
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } catch (err) {
      showError(context, err);
    }
  }

  void showError(context, err) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('error'), content: Text(err.toString())));
  }
}
