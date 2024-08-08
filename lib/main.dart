// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loklokapp/pages/chat_page.dart';
import 'package:loklokapp/pages/login_page.dart';

import 'firebase_options.dart';
import 'pages/registeration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const LoklokApp());
}

class LoklokApp extends StatelessWidget {
  const LoklokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterationPage.id: (context) => const RegisterationPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
