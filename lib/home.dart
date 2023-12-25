import 'package:blood_donation/components/customDropDown.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  TextEditingController address = TextEditingController();
  TextEditingController group = TextEditingController();

  String? selectedCiteisOption;
  List<String> CiteisOptions = ['الدوحة', '1الدوحة'];
  String? selectedBloodGroupOption;
  List<String> bloodGroupOptions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bloodtype), label: "Become Donar"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.email), label: "Requests"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
              BottomNavigationBarItem(icon: Icon(Icons.info), label: "About")
            ]),
        appBar: AppBar(
          title: const Text(
            'Blood Donation Qatar',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('login', (route) => false);
                },
                color: Colors.white,
                icon: Icon(Icons.exit_to_app))
          ],
          backgroundColor: Colors.red,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              color: Colors.red,
              child: Row(children: [
                CustomDropdownMenu(
                  initialSelection:
                      selectedBloodGroupOption ?? bloodGroupOptions.first,
                  menuEntries: bloodGroupOptions,
                  onSelected: (newValue) {
                    setState(() {
                      selectedBloodGroupOption = newValue;
                    });
                  },
                ),
                CustomDropdownMenu(
                  initialSelection: selectedCiteisOption ?? CiteisOptions.first,
                  menuEntries: CiteisOptions,
                  onSelected: (newValue) {
                    setState(() {
                      selectedCiteisOption = newValue;
                    });
                  },
                ),
              ]),
            ),
            Container(
              color: Colors.orange,
              child: TextField(),
            )
          ],
        ),
      ),
    );
  }
}
