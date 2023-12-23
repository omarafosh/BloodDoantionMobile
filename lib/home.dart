import 'package:blood_donation/components/customTextField.dart';
import 'package:blood_donation/pakages/compobox.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
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
  final List<String> dataList = [
    'A',
    'B',
    'C',
    // يمكنك إضافة المزيد من الخيارات هنا
  ];

  String selectedFirstOption = 'Select'; // الخيار المحدد افتراضيًا
  String selectedSecondOption = 'خيار أ'; // الخيار المحدد افتراضيًا

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
        body: ListView(
          children: [
            Compobox(
                datalist: [
                  SelectedListItem(name: "A"),
                  SelectedListItem(name: "B")
                ],
                textEditingController: address,
                title: "Select Address",
                hint: "Address",
                isCitySelected: true),
            Compobox(
                datalist: [
                  SelectedListItem(name: "A"),
                  SelectedListItem(name: "B")
                ],
                textEditingController: address,
                title: "Select Address",
                hint: "Address",
                isCitySelected: true)
          ],
        ),
      ),
    );
  }
}
