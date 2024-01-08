import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String age;
  final String group;
  final String gender;
  final String phone;
  final String available;
  final bool isActive;
  const CustomCard(
      {super.key,
      required this.name,
      required this.age,
      required this.gender,
      required this.group,
      required this.phone,
      required this.available,
      required this.isActive});

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
              name,
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
              group,
              textDirection: TextDirection.ltr,
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
              Text(age.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.red)),
              SizedBox(width: 40),
              Text("الجنس :"),
              Text(gender, style: TextStyle(fontSize: 14, color: Colors.red)),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("رقم الهاتف :"),
                Text(phone,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                    textDirection: TextDirection.ltr),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("متاح : "),
                Text(available,
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
              color: isActive == true ? Colors.green[400] : Colors.red[400],
            ),
          ],
        ),
      ),
    );
  }
}
