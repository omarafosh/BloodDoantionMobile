import 'package:flutter/material.dart';

class AddDonation extends StatefulWidget {
  const AddDonation({super.key});

  @override
  State<AddDonation> createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
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
          body: Text("dd"),
        ),
      ),
    );
  }
}
