import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController DonorName = TextEditingController();
  TextEditingController DonorAge = TextEditingController();
  TextEditingController DonorGender = TextEditingController();
  TextEditingController DonorGroup = TextEditingController();
  TextEditingController DonorPhone1 = TextEditingController();
  TextEditingController DonorPhone2 = TextEditingController();
  TextEditingController DonorAvilable = TextEditingController();
  TextEditingController DonorAddress = TextEditingController();
  String? choiceItem;
  bool isChecked = false;
  String? selectedAvailableOption;
  List<String> availableOptions = <String>['صباحا', 'مساء', 'أي وقت'];

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

  String? selectedGenderOption;
  var GenderOptions = <String>['ذكر', 'انثى'];

  CollectionReference profile =
      FirebaseFirestore.instance.collection("profile");
  Future<void> saveProfile() async {
    await profile
        .add({
          'user_id': FirebaseAuth.instance.currentUser?.uid,
          'name': DonorName.text,
          'age': DonorAge.text,
          'group': selectedBloodGroupOption ?? "A+",
          'gender': selectedGenderOption ?? "ذكر",
          'phone1': DonorPhone1.text,
          'phone2': DonorPhone2.text,
          'avilable': selectedAvailableOption ?? "صباحا",
          'address': selectedCitiesOption ?? "الدوحة",
          'isDonor': isChecked,
        })
        .then((value) {})
        .catchError((error) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'خطأ',
            desc: 'هناك خطأ بإدخال البيانات',
          ).show();
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text(
              'حياة بدمك',
              style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // يقوم بالانتقال إلى الصفحة السابقة
              },
            ),
          ),
          body: Form(
            key: formstate,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الاسم"),
                  ),
                  Container(height: 15),
                  CustomTextField(
                      hintText: "الاسم",
                      MyController: DonorName,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال الاسم';
                        }
                      }),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("العمر"),
                  ),
                  Container(height: 10),
                  CustomTextField(
                    hintText: "العمر",
                    MyController: DonorAge,
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val == "") {
                        return 'الرجاء ادخال العمر';
                      }
                    },
                  ),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الزمرة"),
                  ),
                  Container(height: 10),
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
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الجنس"),
                  ),
                  Container(height: 10),
                  CustomDropdownMenu(
                    initialSelection:
                        selectedGenderOption ?? GenderOptions.first,
                    menuEntries: GenderOptions,
                    onSelected: (newValue) {
                      setState(() {
                        selectedGenderOption = newValue;
                      });
                    },
                  ),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الهاتف 1"),
                  ),
                  Container(height: 10),
                  CustomTextField(
                      hintText: "الهاتف 1",
                      MyController: DonorPhone1,
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال رقم الهاتف';
                        }
                      }),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الهاتف 2"),
                  ),
                  Container(height: 15),
                  CustomTextField(
                      hintText: "الهاتف 2",
                      MyController: DonorPhone2,
                      keyboardType: TextInputType.phone,
                      validator: (val) {}),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("متاح"),
                  ),
                  Container(height: 10),
                  CustomDropdownMenu(
                    initialSelection:
                        selectedAvailableOption ?? availableOptions.first,
                    menuEntries: availableOptions,
                    onSelected: (newValue) {
                      setState(() {
                        selectedAvailableOption = newValue;
                      });
                    },
                  ),
                  Container(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("العنوان"),
                  ),
                  Container(height: 10),
                  CustomDropdownMenu(
                    initialSelection:
                        selectedCitiesOption ?? CitiesOptions.first,
                    menuEntries: CitiesOptions,
                    onSelected: (newValue) {
                      setState(() {
                        selectedCitiesOption = newValue;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked, // القيمة الحالية للـ Checkbox
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked =
                                value ?? false; // تحديث حالة الـ Checkbox
                          });
                        },
                      ),
                      Text(" فعل هذا الخيار لتصبح متبرع في مجتمعنا")
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CustomButton(
                            title: "حفظ و تعديل بيانات المتبرع",
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                try {
                                  saveProfile();
                        
                                  Navigator.of(context)
                                      .pushReplacementNamed("home");
                                } on FirebaseAuthException catch (e) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: '$e',
                                  ).show();
                                }
                              }
                            }),
                                                 CustomButton(
                            title: "تعديل بيانات المتبرع",
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                try {
                                  saveProfile();
                        
                                  Navigator.of(context)
                                      .pushReplacementNamed("home");
                                } on FirebaseAuthException catch (e) {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    title: 'Error',
                                    desc: '$e',
                                  ).show();
                                }
                              }
                            }),
                      ],
                    ),
                        
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
