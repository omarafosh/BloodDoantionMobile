import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:blood_donation/components/customDropDown.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Future<void> fetchUserData() async {
    final user_id = FirebaseAuth.instance.currentUser?.uid;
    if (user_id != null) {
      CollectionReference profile =
          await FirebaseFirestore.instance.collection('profile');

      QuerySnapshot profile_user =
          await profile.where('user_id', isEqualTo: user_id).get();

      if (profile_user.docs.isNotEmpty) {
        setState(() {
          DonorName.text = profile_user.docs.first['name'] ?? "";
          DonorAge.text = profile_user.docs.first['age'] ?? "";
          selectedBloodGroupOption =
              profile_user.docs.first['group'] ?? bloodGroupOptions.first;
          selectedGenderOption =
              profile_user.docs.first['gender'] ?? GenderOptions.first;
          DonorPhone1.text = profile_user.docs.first['phone1'] ?? "";
          DonorPhone2.text = profile_user.docs.first['phone2'] ?? "";
          selectedAvailableOption =
              profile_user.docs.first['avilable'] ?? availableOptions.first;
          selectedCitiesOption =
              profile_user.docs.first['city'] ?? CitiesOptions.first;
          isChecked = profile_user.docs.first['isDonor'] ?? false;
        });
      }
    }
  }

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

  Future<void> updateProfile() async {
    try {
      if (!mounted) return;

      CollectionReference profile =
          FirebaseFirestore.instance.collection("profile");
      var user_id = FirebaseAuth.instance.currentUser?.uid;
      QuerySnapshot querySnapshot = await profile.get();
      String pid = querySnapshot.docs.first.id;
      await profile.doc(pid).update({
        'user_id': user_id,
        'name': DonorName.text ?? "",
        'age': DonorAge.text ?? "",
        'group': selectedBloodGroupOption ?? "A+",
        'gender': selectedGenderOption ?? "ذكر",
        'phone1': DonorPhone1.text ?? "",
        'phone2': DonorPhone2.text ?? "",
        'avilable': selectedAvailableOption ?? "صباحا",
        'city': selectedCitiesOption ?? "الدوحة",
        'isDonor': isChecked,
      });

      Navigator.of(context).pushReplacementNamed("home");

      if (mounted) {}
    } catch (error) {
      if (mounted) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'خطأ',
          desc: 'هناك خطأ في عملية تحديث البيانات ',
        ).show();
      }
    }
  }

  @override
  void initState() {
    fetchUserData();
    super.initState();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            title: "تعديل بيانات المتبرع",
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                try {
                                  if (formstate.currentState!.validate()) {
                                    updateProfile();
                                    Navigator.of(context)
                                        .pushReplacementNamed("home");
                                  }
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
                        SizedBox(
                          width: 30,
                        ),
                        CustomButton(
                            title: "حذف الحساب",
                            onPressed: () {
                              if (formstate.currentState!.validate()) {
                                updateProfile();
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
