import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customCardDonation.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:blood_donation/functions/general.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
  // final DataContoller dataController = Get.find();
  @override
  void initState() {
    performSearch();
    SearchController.addListener(onSerachChanged);
    super.initState();
  }

  onSerachChanged() {
    searchResultList();
  }

  @override
  void didChangeDependencies() {
    performSearch();
    super.didChangeDependencies();
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String Search = "";
  TextEditingController SearchController = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController patiant = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController unit = TextEditingController();
  DateTime selectedDate = DateTime.now();

  bool is120DaysPassed(Timestamp donationTimestamp) {
    Timestamp currentTime = Timestamp.now();
    Duration difference =
        currentTime.toDate().difference(donationTimestamp.toDate());
    return difference.inDays >= 120;
  }

  List _allResults = [];
  List _resultList = [];

  searchResultList() {
    var temp = [];
    if (SearchController.text != "") {
      for (var dataSearch in _allResults) {
        var id = dataSearch['id'].toString().toLowerCase();
        if (id.contains(SearchController.text.toLowerCase())) {
          temp.add(dataSearch);
        }
      }
    } else {
      temp = List.from(_allResults);
    }
    setState(() {
      _resultList = temp;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  void performSearch() async {
    var user_id = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('donations')
        .where('user_id', isEqualTo: user_id)
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _allResults = data.docs;
      searchResultList();
    });
  }

  Future<void> saveDonate() async {
    CollectionReference donations =
        FirebaseFirestore.instance.collection("donations");

    DocumentReference docRef = await donations.add({
      'user_id': FirebaseAuth.instance.currentUser?.uid,
      'id': id.text,
      'patiant': patiant.text,
      'hospital': hospital.text,
      'date': selectedDate,
      'unit': unit.text,
      'isActive': true,
    });

// استخدام معرّف الوثيقة الجديدة في الحفظ
    await docRef.update({
      'doc_id': docRef.id,
    }).then((value) {
      performSearch();
    }).catchError((error) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'خطأ',
        desc: 'هناك خطأ بإدخال البيانات',
      ).show();
    });
  }

  void deleteDonation(String docId, int index) async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'هل انت متأكد من عملية الحذف ؟',
      btnOkOnPress: () async {
        setState(() {
          _resultList.removeAt(index);
        });
        await FirebaseFirestore.instance
            .collection("donations")
            .doc(docId)
            .delete()
            .then((value) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'تم الحذف بنجاح',
          ).show();
        }).catchError((error) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'خطأ',
            desc: 'حدثت مشكلة أثناء الحذف',
          ).show();
        });
      },
      btnCancelOnPress: () {},
    ).show();
  }

  @override
  void dispose() {
    SearchController.removeListener(onSerachChanged);
    SearchController.dispose();
    id.dispose();
    patiant.dispose();
    hospital.dispose();
    date.dispose();
    unit.dispose();
    super.dispose();
  }

  Future<void> _showInputAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Theme(
            data: ThemeData(
              canvasColor: Colors.orange,
              fontFamily: "Cairo",
            ),
            child: AlertDialog(
              title: Text('ادخل بيانات التبرع'),
              content: Container(
                child: Form(
                  key: formstate,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                        hintText: "الرقم الشخصي",
                        MyController: id,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الرقم الشخصي';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 2),
                      CustomTextField(
                        hintText: "اسم المريض",
                        MyController: patiant,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال اسم المريض  ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 2),
                      CustomTextField(
                          hintText: "اسم المشفى",
                          MyController: hospital,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال اسم المشفى  ';
                            }
                            return null;
                          }),
                      SizedBox(height: 2),
                      TextFormField(
                        controller: date,
                        onTap: () => _selectDate(
                            context), // Open date picker when tapping on the TextFormField
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "حدد تاريخ التبرع",
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال  تاريخ التبرع  ';
                          }
                          return null;
                        },
                        readOnly: true,
                      ),
                      CustomTextField(
                          hintText: "عدد الوحدات",
                          MyController: unit,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال   عدد الوحدات  ';
                            }
                            return null;
                          })
                    ],
                  ),
                ),
              ),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          // إذا كانت البيانات صحيحة، قم بمعالجتها
                          var canDonate =
                              await isWithin120Days(selectedDate).then((value) {
                            if (!value) {
                              saveDonate();
                              id.clear();
                              patiant.clear();
                              hospital.clear();
                              date.clear();
                              unit.clear();
                              Navigator.of(context).pop();
                            } else {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'تنبيه',
                                desc:
                                    'لا يمكن تسجيل عملية التبرع لانه لم يمضي اكثر من 120 يوم',
                              ).show();
                            }
                          });

                          // معالجة القيم...
                        }
                        // Close the dialog on submit
                      },
                      child: Text('موافق', style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Close the dialog on cancel
                      },
                      child: Text(
                        'الغاء الامر',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                _showInputAlertDialog(context);
              }),
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text(
              'حياة بدمك',
              style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text("قائمة  تبرعاتي"),
              SizedBox(
                height: 15,
              ),
              CupertinoSearchTextField(
                controller: SearchController,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: _resultList.length,
                    itemBuilder: (context, index) {
                      return CustomCardDonation(
                        id: _resultList[index]['id'],
                        patient: _resultList[index]['patiant'],
                        hospital: _resultList[index]['hospital'],
                        date: _resultList[index]['date'],
                        unit: "2",
                        doc_id: _resultList[index]['doc_id'],
                        onDelete: () {
                          deleteDonation(_resultList[index]['doc_id'], index);
                        },
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
