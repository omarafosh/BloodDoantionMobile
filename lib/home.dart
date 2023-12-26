import 'package:blood_donation/components/customDropDown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  String? selectedCitiesOption;

  List<String> CitiesOptions = [
    'الدوحة',
    'الخور',
    'الشمال',
    'الوكرة',
    'الوسيل',
    'دخان',
    'مسيعيد',
    'الشيخانية'
  ];
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
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getDonors() async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("donors").get();
    data.addAll(query.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getDonors();
    super.initState();
  }

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
        body: Container(
          height: 140,
          color: const Color.fromRGBO(239, 154, 154, 1),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Column(children: [
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
            Container(
              height: 10,
            ),
            CustomDropdownMenu(
              initialSelection: selectedCitiesOption ?? CitiesOptions.first,
              menuEntries: CitiesOptions,
              onSelected: (newValue) {
                setState(() {
                  selectedCitiesOption = newValue;
                });
              },
            ),
          ]),
        ),
      ),
    );
  }
}
