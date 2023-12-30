import 'package:blood_donation/add_donation.dart';
import 'package:blood_donation/components/customCardDonation.dart';
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
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddDonation()));
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
              CustomTextField(
                  hintText: "ادخل الرقم الشخصي",
                  MyController: Search,
                  keyboardType: TextInputType.number),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      CustomCardDonation(
                        id: "12313484334",
                        hospital: "الحماد الحكومي" ,
                        patient: "سمير محمد عواد",
                        date: "27/09/2021",
                        unit: 3,
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
