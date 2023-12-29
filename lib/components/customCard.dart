import 'package:blood_donation/components/customGroup.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

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
              " الاسم : ",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "محمد حسين العيسى",
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ],
        ),
        leading: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "images/group.png",
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
            Text(
              "A+",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(children: [
              Text("العمر :"),
              Text(" 39", style: TextStyle(fontSize: 14, color: Colors.red)),
              SizedBox(width: 40),
              Text("الجنس :"),
              Text(" ذكر", style: TextStyle(fontSize: 14, color: Colors.red)),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("رقم الهاتف :"),
                Text(" 709898589",
                    style: TextStyle(fontSize: 14, color: Colors.red)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("متاح : "),
                Text(" صباحا",
                    style: TextStyle(fontSize: 14, color: Colors.red)),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.star,
              size: 25,
              color: Colors.brown,
            ),
            SizedBox(
              height: 5,
            ),
            Icon(
              Icons.circle,
              size: 15,
              color: Colors.green[400],
            ),
          ],
        ),
      ),
    );
  }
}
