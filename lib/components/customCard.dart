import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:blood_donation/functions/general.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String age;
  final String group;
  final String gender;
  final String phone;
  final String available;
  final bool isActive;
  final int isEvaluation;
  final String message_id;
  const CustomCard(
      {super.key,
      required this.name,
      required this.age,
      required this.gender,
      required this.group,
      required this.phone,
      required this.available,
      required this.isActive,
      required this.isEvaluation,
      required this.message_id});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    TextEditingController _thankController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();
    final currentUserID = FirebaseAuth.instance.currentUser!.uid;
    Future<String?> getUserEmail(String userId) async {
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('profile')
            .doc(userId)
            .get();

        if (userSnapshot.exists) {
          return userSnapshot.get('email');
        } else {
          return null; // يمكنك تعديل هذا السلوك حسب حالتك
        }
      } catch (error) {
        print('Error getting user email: $error');
        return null;
      }
    }

    void sendMessage() async {
      print(_messageController.text);
      if (_messageController.text.isNotEmpty) {
        final currentUserID = FirebaseAuth.instance.currentUser!.uid;

        // تحقق مما إذا كان المرسل هو المستخدم الحالي
        if (name != currentUserID) {
          try {
            await FirebaseFirestore.instance.collection('messages').add({
              'name': getUserEmail(message_id),
              'body': _messageController.text,
              'date': DateTime.now(),
              'type': 'sent',
              'user_id': message_id,
            });

            // رسالة تأكيد الإرسال
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم إرسال الرسالة بنجاح')),
            );
          } catch (error) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'خطأ',
              desc: 'لا يمكنك إرسال رسالة لنفسك',
            ).show();
          }
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'خطأ',
            desc: 'لا يمكنك إرسال رسالة لنفسك',
          ).show();
        }
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'خطأ',
          desc: 'لا يمكنك ان يكون نص الرسالة فارغا',
        ).show();
      }
    }

    return Card(
      elevation: 1,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
      child: ListTile(
        title: Row(
          children: [
            Text(
              " الاسم : ",
              style: TextStyle(fontSize: 12),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
        leading: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Image.asset(
              "images/group.png",
              width: 50,
              height: 50,
            ),
            Text(
              group,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        subtitle: Column(
          children: [
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Row(children: [
              Text("العمر : ", style: TextStyle(fontSize: 12)),
              Text(age.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.red)),
              SizedBox(width: screenSize.width * 0.01),
              Text("الجنس : ", style: TextStyle(fontSize: 12)),
              Text(gender, style: TextStyle(fontSize: 12, color: Colors.red)),
            ]),
            SizedBox(
              height: screenSize.height * 0.01,
            ),
            Row(
              children: [
                Text("رقم الهاتف : ",
                    style: TextStyle(
                      fontSize: 12,
                    )),
                Text(phone,
                    style: TextStyle(fontSize: 12, color: Colors.red),
                    textDirection: TextDirection.ltr),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("متاح : ", style: TextStyle(fontSize: 12)),
                Text(available,
                    style: TextStyle(fontSize: 12, color: Colors.red)),
                IconButton(
                  icon: Icon(
                    Icons.phone_android,
                    size: 18,
                    color: Colors.green[600],
                  ),
                  onPressed: () {
                    launchTel();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.message,
                    size: 18,
                    color: Color.fromARGB(255, 214, 180, 30),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2.0))),
                          contentTextStyle: TextStyle(fontSize: 14),
                          title: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(name,
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.red)),
                                Text('  المرسل اليه : ',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(fontSize: 14)),
                              ]),
                          content: TextField(
                            style: TextStyle(fontSize: 12, color: Colors.red),
                            controller: _messageController,
                            minLines: 2,
                            maxLines: 2,
                            textDirection: TextDirection.rtl, // يسمح بعدة أسطر
                            decoration: InputDecoration(
                              hintText: "ادخل نص الرسالة",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // لإغلاق الـ AlertDialog
                                  },
                                  child: Text('الغاء الامر',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red)),
                                ),
                                CustomButton(
                                  title: 'ارسال',
                                  onPressed: () {
                                    sendMessage();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "images/level.png",
              width: 30,
              height: 30,
              color: isEvaluation >= 2
                  ? Colors.yellow[600]
                  : (isEvaluation == 0
                      ? Colors.white
                      : Color.fromARGB(255, 136, 134, 134)),
            ),
            SizedBox(
              height: screenSize.height * 0.01,
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
