import 'package:flutter/material.dart';

class CustomCardDonation extends StatelessWidget {
  const CustomCardDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      child: ListTile(
        title: Column(
          children: [
            Row(children: [
              Text(
                " الرقم الشخصي : ",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                "213469798789",
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            ]),
            Row(
              children: [
                Text(
                  " اسم المريض : ",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "سمير محمد السعيد",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              ],
            )
          ],
        ),
        subtitle: Column(
          children: [
            Row(children: [
              Text("اسم المستشفى :", style: TextStyle(fontSize: 12)),
              Text(" الحماد الحكومي",
                  style: TextStyle(fontSize: 12, color: Colors.red)),
            ]),
            Row(
              children: [
                Text("تاريخ التبرع :", style: TextStyle(fontSize: 12)),
                Text(" 12-11-2023",
                    style: TextStyle(fontSize: 12, color: Colors.red)),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("عدد الوحدات", style: TextStyle(fontSize: 12)),
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 35,
                  color: Colors.white,
                ),
                Text("2", style: TextStyle(fontSize: 16, color: Colors.red))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
