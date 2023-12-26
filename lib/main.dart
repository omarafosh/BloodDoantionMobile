import 'package:blood_donation/add_donor.dart';
import 'package:blood_donation/auth/login.dart';
import 'package:blood_donation/auth/signup.dart';
import 'package:blood_donation/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: (FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? const Home() : const Login(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "home": (context) => Home(),
        "adddonar": (context) => AddDonor(),
      },
    );
  }
}
