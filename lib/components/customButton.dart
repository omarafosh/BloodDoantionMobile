import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.red[400],
      textColor: Colors.white,
      onPressed: onPressed,
      child:Center(child: Text(title)),
    );
  }
}
