import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customCardDonation.dart';
import 'package:blood_donation/components/customTextField.dart';
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

  List _allResults = [];
  List _resultList = [];
  

  searchResultList() {
    var temp = [];
    if (SearchController.text!=""){
      for (var dataSearch in _allResults){
        var id=dataSearch['id'].toString().toLowerCase();
        if (id.contains(SearchController.text.toLowerCase())){
          temp.add(dataSearch);
        }
      }

    }else{
      temp=List.from(_allResults);
    }
    setState(() {
      _resultList=temp;
    });
  }
void performSearch() async {
    var data = await FirebaseFirestore.instance
        .collection('donations')
        .orderBy("date")
        .get();

    setState(() {
      _allResults = data.docs;
    });
    searchResultList();
  }
  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String Search = "";
  TextEditingController SearchController = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController patiant = TextEditingController();
  TextEditingController hospital = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController unit = TextEditingController();
  Future<void> saveDonate() async {
    CollectionReference donations =
        FirebaseFirestore.instance.collection("donations");
    await donations
        .add({
          'user_id': FirebaseAuth.instance.currentUser?.uid,
          'id': id.text,
          'patiant': patiant.text,
          'hospital': hospital.text,
          'date': date.text,
          'unit': int.parse(unit.text),
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
        performSearch();
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
                      CustomTextField(
                          hintText: "تاريخ التبرع",
                          MyController: date,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء إدخال  تاريخ التبرع  ';
                            }
                            return null;
                          }),
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
                      onPressed: () {
                        // Process the entered values

                        // Do something with the values

                        // Clear the text fields after processing

                        if (formstate.currentState!.validate()) {
                          // إذا كانت البيانات صحيحة، قم بمعالجتها
                          saveDonate();
                          // معالجة القيم...
                          id.clear();
                          patiant.clear();
                          hospital.clear();
                          date.clear();
                          unit.clear();
                          Navigator.of(context).pop();
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
                        unit: _resultList[index]['unit'],
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
