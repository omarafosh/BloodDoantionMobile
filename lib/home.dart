import 'package:blood_donation/about.dart';
import 'package:blood_donation/components/customCard.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/donation.dart';
import 'package:blood_donation/functions/general.dart';
import 'package:blood_donation/profile.dart';
import 'package:blood_donation/profile_edit.dart';
import 'package:blood_donation/thank.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeController extends GetxController {
  var selectedCitiesOption = 'الكل'.obs;
  var selectedBloodGroupOption = 'الكل'.obs;
  var isLoading = true.obs;
  var resultList = [].obs;
  var isActive = true.obs;
  var islevel = 0.obs;

  Future<bool> getIsActiveValue() async {
    // الحصول على معرف المستخدم الحالي
    String? currentUserUID = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserUID != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('profile')
          .where("user_id", isEqualTo: currentUserUID)
          .get();

      // التحقق مما إذا كان هناك قيمة مخزنة في الحقل isActive
      if (snapshot.docs.isNotEmpty && snapshot.docs.first != null) {
        isActive.value = snapshot.docs.first["isActive"];
        isActive.refresh();

        return isActive.value;
      }
    }
    return false; // قيمة افتراضية في حالة عدم وجود الوثيقة أو الحقل
  }

  final List<String> CitiesOptions = [
    'الكل',
    'الدوحة',
    'الخور',
    'الشمال',
    'الوكرة',
    'الوسيل',
    'دخان',
    'مسيعيد',
    'الشيخانية'
  ];

  final List<String> bloodGroupOptions = [
    'الكل',
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
  void onInit() {
    super.onInit();
    getIsActiveValue();
    getDonors(); // ابدأ بجلب البيانات عند فتح الصفحة
  }

  void getDonors() async {
    var user_id = await FirebaseAuth.instance.currentUser!.uid;
    Query query = FirebaseFirestore.instance.collection("profile");

    if (selectedCitiesOption.value != 'الكل') {
      query = query.where('city', isEqualTo: selectedCitiesOption.value);
    }

    if (selectedBloodGroupOption.value != 'الكل') {
      query = query.where('group', isEqualTo: selectedBloodGroupOption.value);
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where('user_id',
            isNotEqualTo: user_id) // استبعاد بيانات المستخدم الحالي
        .where('isDonor', isEqualTo: true) // فقط المستخدمين المتبرعين
        .orderBy('user_id', descending: true)
        .orderBy('isEvaluation', descending: true)
        .orderBy('isActive', descending: true)
        .get();

    if (selectedCitiesOption.value == 'الكل' &&
        selectedBloodGroupOption.value == 'الكل') {
      resultList.value = querySnapshot.docs;
    } else {
      resultList.value = querySnapshot.docs;
    }

    isLoading.value = false;
  }

  void updateDonorStatus() async {
    QuerySnapshot donorSnapshot =
        await FirebaseFirestore.instance.collection('profile').get();
    donorSnapshot.docs.forEach((doc) {
      if (isWithin120Days(Timestamp.now().toDate()) == true) {
        FirebaseFirestore.instance.collection('profile').doc(doc.id).update({
          'isActive': true,
        });
      } else {
        FirebaseFirestore.instance.collection('profile').doc(doc.id).update({
          'isActive': false,
        });
      }
    });
  }
}

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  height: 200,
                  color: Colors.red,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   "images/logo.jpg",
                        //   width: 50,
                        //   height: 50,
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName
                              .toString(),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ]),
                ),
                ListTile(
                  title: Text('الصفحة الرئيسية'),
                  leading: Icon(
                    Icons.home,
                    color: Colors.red,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("home");
                  },
                ),
                ListTile(
                  title: Text('ملفي الشخصي'),
                  leading: Icon(
                    Icons.person,
                    color: Colors.red,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfileEdit()));
                  },
                ),
                ListTile(
                  title: Text('تبرعاتي السابقة'),
                  leading: Icon(
                    Icons.bloodtype_outlined,
                    color: Colors.red,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Donation()));
                  },
                ),
                ListTile(
                  title: Text('صندوق البريد '),
                  leading: Icon(
                    Icons.mail,
                    color: Colors.red,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => Thank()));
                  },
                ),
                ListTile(
                  title: Text('حول البرنامج'),
                  leading: Icon(
                    Icons.info,
                    color: Colors.red,
                    size: 32,
                  ),
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
              'حياة بدمك',
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
          body: Obx(
            () => Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        CustomDropdownMenu(
                          initialSelection:
                              controller.selectedCitiesOption.value,
                          menuEntries: controller.CitiesOptions,
                          onSelected: (newValue) {
                            controller.selectedCitiesOption.value =
                                newValue.toString();
                            controller.getDonors();
                          },
                        ),
                        SizedBox(
                          height: screenSize.height * 0.01,
                        ),
                        CustomDropdownMenu(
                          initialSelection:
                              controller.selectedBloodGroupOption.value,
                          menuEntries: controller.bloodGroupOptions,
                          onSelected: (newValue) {
                            controller.selectedBloodGroupOption.value =
                                newValue.toString();
                            controller.getDonors();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "نتائج البحث : ${controller.resultList.length}",
                  textDirection: TextDirection.rtl,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.resultList.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            message_id: controller.resultList[index]["user_id"],
                            name: controller.resultList[index]["name"],
                            age: controller.resultList[index]["age"],
                            group: controller.resultList[index]["group"],
                            phone: controller.resultList[index]["phone1"],
                            gender: controller.resultList[index]["gender"],
                            isActive: controller.isActive.value,
                            isEvaluation: controller.islevel.value,
                            available: controller.resultList[index]["avilable"],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
