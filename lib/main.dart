import 'package:blood_donation/about.dart';
import 'package:blood_donation/profile.dart';
import 'package:blood_donation/auth/login.dart';
import 'package:blood_donation/auth/signup.dart';
import 'package:blood_donation/home.dart';
import 'package:blood_donation/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> ScaffoldKey = GlobalKey();
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
      home: Scaffold(
        key: ScaffoldKey,
        body: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? Home()
            : Splash(),
      ),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "splash": (context) => Splash(),
        "home": (context) => Home(),
        "profile": (context) => Profile(),
        "about": (context) => About(),
      },
    );
  }
}
