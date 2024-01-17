import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomCardDonation extends StatelessWidget {
  final String id;
  final String patient;
  final String hospital;
  final Timestamp date;
  final String unit;
  final String doc_id;
  final Function() onDelete;

  const CustomCardDonation({
    super.key,
    required this.id,
    required this.patient,
    required this.hospital,
    required this.date,
    required this.unit,
    required this.doc_id,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
                style: TextStyle(fontSize: 14),
              ),
              Text(
                id,
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ]),
            Row(
              children: [
                Text(
                  " اسم المريض : ",
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  patient,
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ],
            )
          ],
        ),
        subtitle: Column(
          children: [
            Row(children: [
              Text("اسم المستشفى : ", style: TextStyle(fontSize: 14)),
              Text(hospital, style: TextStyle(fontSize: 14, color: Colors.red)),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text("تاريخ التبرع : ", style: TextStyle(fontSize: 14)),
                Text(
                    '${date.toDate().day}-${date.toDate().month}-${date.toDate().year}',
                    style: TextStyle(fontSize: 14, color: Colors.red)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("الوحدات", style: TextStyle(fontSize: 14)),
                    SizedBox(
                      width: 8,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.circle,
                          size: 25,
                          color: Colors.white,
                        ),
                        Text(unit,
                            style: TextStyle(fontSize: 14, color: Colors.red)),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  child: Icon(Icons.delete, size: 25, color: Colors.red),
                  onTap: onDelete,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
