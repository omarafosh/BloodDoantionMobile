import 'package:blood_donation/components/customCardThank.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:flutter/material.dart';

class Donation extends StatefulWidget {
  const Donation({super.key});

  @override
  State<Donation> createState() => _DonationState();
}

class _DonationState extends State<Donation> {
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
                      customCardThank(),
                      customCardThank(),
                      customCardThank()
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
