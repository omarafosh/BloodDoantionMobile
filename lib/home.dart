import 'package:blood_donation/about.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // يمكنك الوصول إلى متغير الحالة العامة من أي مكان باستخدام Provider.of<AppData>(context)

  int selectedIndex = 0;
  TextEditingController address = TextEditingController();
  TextEditingController group = TextEditingController();

// لتحديث قيمة المتغير العام

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
    print(data);
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
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                ListTile(
                  title: Text('الصفحة الرئيسية'),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("home");
                  },
                ),
                ListTile(
                  title: Text('تبرعاتي'),
                  leading: Icon(Icons.bloodtype_outlined),
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                  },
                ),
                ListTile(
                  title: Text('رسائل الشكر'),
                  leading: Icon(Icons.bloodtype_outlined),
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About()));
                  },
                ),
                ListTile(
                  title: Text('ملفي الشخصي'),
                  leading: Icon(Icons.bloodtype_outlined),
                  onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));
                  },
                ),
                                ListTile(
                  title: Text('حول البرنامج'),
                  leading: Icon(Icons.bloodtype_outlined),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>About()));
                  },
                ),
              ],
            ),
          ),
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
      ),
    );
  }
}
