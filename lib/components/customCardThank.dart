import 'package:blood_donation/components/customGroup.dart';
import 'package:flutter/material.dart';

class CustomCardThank extends StatelessWidget {
  const CustomCardThank({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      child: ListTile(
        title: Row(
          children: [
            Text(
              " اسم المريض : ",
              style: TextStyle(fontSize: 13),
            ),
            Text(
              "احمد سعيد الحاج علي",
              style: TextStyle(fontSize: 13, color: Colors.red),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
        
              Text("نشكر لكم بذلكم و جعلها الله في",style: TextStyle(fontSize: 13, color: Colors.blue)),
            SizedBox(
              height: 5,
            ),
           
            SizedBox(
              height: 10,
            ),
            Text("12-12-2023",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, color: Colors.green)),
          ],
        ),
     trailing: Icon(Icons.delete,color: Colors.red,),
      ),
    );
  }
}
