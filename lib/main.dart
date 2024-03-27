import 'dart:developer';
import 'package:chatapp2/categories/add_categories.dart';

import 'package:chatapp2/firebase_options.dart';
import 'package:chatapp2/notes/add_notes.dart';
import 'package:chatapp2/notes/notes_view.dart';
import 'package:chatapp2/views/auth/login_view.dart';
import 'package:chatapp2/views/auth_view.dart';
import 'package:chatapp2/views/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp2());
}

class ChatApp2 extends StatefulWidget {
  const ChatApp2({super.key});

  @override
  State<ChatApp2> createState() => _ChatApp2State();
}

class _ChatApp2State extends State<ChatApp2> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // 'AddNotes': (context) => const AddNotes(),
        'AddCategories': (context) => const AddCategories(),
        'LoginView': (context) => const LoginView(),
        'HomeView': (context) => const HomeView(),
        'AuthView': (context) => const AuthView(),

        // 'EditCategories': (context) => const EditCategories(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: Colors.blue,
            size: 30,
          ),
          backgroundColor: Colors.grey[300],
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        useMaterial3: false,
      ),
      home: FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? const HomeView()
          : const AuthView(),
    );
  }
}
