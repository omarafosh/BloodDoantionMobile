import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController Mycontroller;
  final String? Function(String?)? validator ;
  const CustomTextField({super.key, required this.hintText, required this.Mycontroller, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:validator ,
      
      controller:Mycontroller ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        // contentPadding: EdgeInsets.all(12),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),

        ),

    // Adjust as needed

      ),
    );
  }
}
