import 'package:chat_app/Screens/chat_Screen.dart';
import 'package:chat_app/Screens/login_Screen.dart';
import 'package:chat_app/Screens/registration_Screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        registrationScreen.id: (context) => registrationScreen(),
        loginScreen.id: (context) => loginScreen(),
        chatScreen.id: (context) => chatScreen(),
      },
      initialRoute: loginScreen.id,
      debugShowCheckedModeBanner: false,
      home: loginScreen(),
    );
  }
}
