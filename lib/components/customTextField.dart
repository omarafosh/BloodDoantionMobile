import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController MyController;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onchange;
  final Function(String?)? onTap;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.MyController,
    required this.keyboardType,

    this.validator,
    this.onchange,
    this.onTap,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextInputType selectedKeyboardType;

  @override
  void initState() {
    super.initState();
    selectedKeyboardType = widget.keyboardType;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onchange,
      keyboardType: selectedKeyboardType,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      // ],

      // يُعد تحديد الاتجاه مهما للنصوص باللغة العربية
      textDirection: TextDirection.rtl,
      controller: widget.MyController,
      onTap: widget.onTap != null ? () => widget.onTap : null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
