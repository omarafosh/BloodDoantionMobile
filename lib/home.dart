import 'package:blood_donation/about.dart';
import 'package:blood_donation/components/customCard.dart';
import 'package:blood_donation/components/customCardThank.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/components/customGroup.dart';
import 'package:blood_donation/donation.dart';
import 'package:blood_donation/profile.dart';
import 'package:blood_donation/thank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  // getDonors() async {
  //   QuerySnapshot query =
  //       await FirebaseFirestore.instance.collection("donors").get();
  //   data.addAll(query.docs);
  //   print(data);
  //   isLoading = false;
  //   setState(() {});
  // }

  List _resultList = [];
  // ignore: non_constant_identifier_names
  var SearchCount;
  getDonors() async {
    Query query = FirebaseFirestore.instance.collection("profile");

    if (selectedCitiesOption != null) {
      query = query.where('city', isEqualTo: selectedCitiesOption);
    }

    if (selectedBloodGroupOption != null) {
      query = query.where('group', isEqualTo: selectedBloodGroupOption);
    }

    QuerySnapshot querySnapshot = await query.get();

    data = querySnapshot.docs;
    print(data);
    isLoading = false;
    setState(() {
      _resultList = data;
    });
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
                  title: Text('ملفي الشخصي'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                ListTile(
                  title: Text('تبرعاتي السابقة'),
                  leading: Icon(Icons.bloodtype_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Donation()));
                  },
                ),
                ListTile(
                  title: Text('صندوق البريد '),
                  leading: Icon(Icons.mail),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Thank()));
                  },
                ),
                ListTile(
                  title: Text('حول البرنامج'),
                  leading: Icon(Icons.info),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => About()));
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
                    GoogleSignIn googleSignIn = GoogleSignIn();
                    googleSignIn.disconnect();
                  },
                  color: Colors.white,
                  icon: Icon(Icons.exit_to_app))
            ],
            backgroundColor: Colors.red,
          ),
          body: Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  CustomDropdownMenu(
                    initialSelection:
                        selectedCitiesOption ?? CitiesOptions.first,
                    menuEntries: CitiesOptions,
                    onSelected: (newValue) {
                      setState(() {
                        selectedCitiesOption = newValue;
                        getDonors();
                        SearchCount = data.length;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomDropdownMenu(
                    initialSelection:
                        selectedBloodGroupOption ?? bloodGroupOptions.first,
                    menuEntries: bloodGroupOptions,
                    onSelected: (newValue) {
                      setState(() {
                        selectedBloodGroupOption = newValue;
                        getDonors();
                        SearchCount = data.length;
                      });
                    },
                  ),
                ]),
              ),
            ),
            Text(
              "نتائج البحث : ${_resultList.length}",
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: _resultList.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      name: _resultList[index]["name"],
                      age: _resultList[index]["age"],
                      group: _resultList[index]["group"],
                      phone: _resultList[index]["phone1"],
                      gender: _resultList[index]["gender"],
                      isActive: _resultList[index]["isDonor"],
                      available: _resultList[index]["avilable"],
                    );
                  },
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
