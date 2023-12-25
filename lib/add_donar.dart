import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddDonar extends StatefulWidget {
  const AddDonar({super.key});

  @override
  State<AddDonar> createState() => _AddDonarState();
}

class _AddDonarState extends State<AddDonar> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  TextEditingController DonorName = TextEditingController();
  TextEditingController DonorAge = TextEditingController();
  TextEditingController DonorPhone1 = TextEditingController();
  TextEditingController DonorPhone2 = TextEditingController();
  TextEditingController DonorGender = TextEditingController();
  TextEditingController DonorGroup = TextEditingController();
  TextEditingController DonorAvilable = TextEditingController();
  TextEditingController DonorAddress = TextEditingController();

  String? choiceItem;
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

  String? selectedGenderOption;
  List<String> GenderOptions = ['ذكر', 'انثى'];
  CollectionReference donors = FirebaseFirestore.instance.collection("donors");
  Future<void> Add_donors() async {
    await donors
        .add({
          'name': DonorName.text,
        })
        .then((value) => print("add user"))
        .catchError((error) => print("error $error"));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        // add this
        textDirection: TextDirection.rtl, // set this property
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text(
              'Blood Donation Qatar',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Form(
            key: formstate,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الاسم"),
                  ),
                  Container(height: 15),
                  CustomTextField(
                      hintText: "الاسم",
                      Mycontroller: DonorName,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال الاسم';
                        }
                      }),
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("العمر"),
                  ),
                  Container(height: 10),
                  CustomTextField(
                      hintText: "العمر",
                      Mycontroller: DonorAge,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال العمر';
                        }
                      }),
                  Container(height: 10),
                  Padding(
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
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الهاتف 1"),
                  ),
                  Container(height: 10),
                  CustomTextField(
                      hintText: "الهاتف 1",
                      Mycontroller: DonorPhone1,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال رقم الهاتف';
                        }
                      }),
                  Container(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("الهاتف 2"),
                  ),
                  Container(height: 15),
                  CustomTextField(
                      hintText: "الهاتف 2",
                      Mycontroller: DonorPhone1,
                      validator: (val) {}),
                  Container(height: 10),
                  Padding(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("العنوان"),
                  ),
                  Container(height: 10),
                  CustomTextField(
                      hintText: "العنوان",
                      Mycontroller: DonorAddress,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال العنوان';
                        }
                      }),
                  Container(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomButton(
                        title: "حفظ و تعديل بيانات المتبرع",
                        onPressed: () {
                          if (formstate.currentState!.validate()) {
                            try {
                              Add_donors();
                              print('save');
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
