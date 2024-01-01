import 'package:flutter/material.dart';

class CustomCardDonation extends StatelessWidget {
  final String id;
  final String patient;
  final String hospital;
  final String date;
  final int unit;
  const CustomCardDonation(
      {super.key,
      required this.id,
      required this.patient,
      required this.hospital,
      required this.date,
      required this.unit});

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
                id,
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
                  patient,
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
              Text(hospital, style: TextStyle(fontSize: 12, color: Colors.red)),
            ]),
            Row(
              children: [
                Text("تاريخ التبرع :", style: TextStyle(fontSize: 12)),
                Text(date, style: TextStyle(fontSize: 12, color: Colors.red)),
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
                Text(unit.toString() ,
                    style: TextStyle(fontSize: 16, color: Colors.red))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
