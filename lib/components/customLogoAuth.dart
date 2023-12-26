import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 150,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(70)),
          child: Image.asset(
            "images/logo.jpg",
            height: 150,
            // fit: BoxFit.fill,
          )),
    );
  }
}
