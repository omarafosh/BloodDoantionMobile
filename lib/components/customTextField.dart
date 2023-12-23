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
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Color.fromARGB(255, 252, 249, 249)),
        ),
      ),
    );
  }
}
