import 'package:blood_donation/components/customCardThank.dart';
import 'package:blood_donation/functions/general.dart';
import 'package:flutter/material.dart';

class Thank extends StatefulWidget {
  const Thank({super.key});

  @override
  State<Thank> createState() => _ThankState();
}

class _ThankState extends State<Thank> {
  TextEditingController Search = TextEditingController();
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
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Text("قائمة رسائل الشكر"),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      CustomCardThank(
                        name: "سامر محمد سعيد",
                        body: insertNewLineAfterCharacterCount(
                            "نشكر لكم جهودكم و جعلها الله في ميزان حسناتكم",
                            38),
                        date: "12-12-2023",
                      ),
                    ],
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
