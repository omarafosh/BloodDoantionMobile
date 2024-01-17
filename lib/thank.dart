import 'package:blood_donation/components/customCardThank.dart';
import 'package:blood_donation/functions/general.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Thank extends StatelessWidget {
  const Thank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: DefaultTabController(
        length: 2,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red,
              title: const Text(
                'حياة بدمك',
                style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'البريد الصادر'),
                  Tab(text: 'البريد الوارد'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ThankList(type: 'sent'), // عرض البريد الصادر
                ThankList(type: 'received'), // عرض البريد الوارد
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ThankList extends StatelessWidget {
  final String type;

  const ThankList({required this.type});

  @override
  Widget build(BuildContext context) {
    final currentUserID =
        FirebaseAuth.instance.currentUser!.uid; // استبدال بمعرف المستخدم الحالي

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .where('type', isEqualTo: type)
          .where(
            type == 'sent' ? 'sender_id' : 'recipient_id',
            isEqualTo: currentUserID,
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> messageData =
                  documents[index].data() as Map<String, dynamic>;
              return CustomCardThank(
                name: messageData['name'],
                body: insertNewLineAfterCharacterCount(messageData['body'], 38),
                date: formatFirestoreTimestamp(messageData['date']),
              );
            },
          ),
        );
      },
    );
  }
}
