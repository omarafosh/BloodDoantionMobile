import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(items: const [
          BottomNavigationBarItem(backgroundColor: Colors.red,icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: "Become Donar"),
          BottomNavigationBarItem(icon: Icon(Icons.find_in_page), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.request_page), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: "Profile")
        ]),
        appBar: AppBar(
          title: const Text(
            'Blood Donation Qatar',
            style: TextStyle(color: Colors.white),
           
          ),
          actions: [IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
           Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
          },color: Colors.white, icon: Icon(Icons.exit_to_app))],
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
