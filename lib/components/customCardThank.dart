import 'package:flutter/material.dart';

class CustomCardThank extends StatelessWidget {
  final String name;
  final String body;
  final String date;
  const CustomCardThank(
      {super.key, required this.name, required this.body, required this.date});

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
              name,
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
            Text(body,
                style: TextStyle(fontSize: 13, color: Colors.blue)),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            ),
            Text(date,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.green)),
          ],
        ),
        trailing: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
