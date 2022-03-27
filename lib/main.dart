import 'package:class_project_chat_app/chat_screen/chat_screen_page.dart';
import 'package:class_project_chat_app/views/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');

  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null ? const ChatPage(): const LoginPage(),
  ));
}