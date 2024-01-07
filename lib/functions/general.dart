import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// String convertDateToSTring(timeStamp) {
//   return DateFormat("dd-MM-yyyy").format(timeStamp).toString();
// }
String convertStringToDateASTimestamp(DateTime date) {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(date);
}
Timestamp convertStringToDateASTimestamp1(dateString) {
// استبدل هذا بالسلسلة النصية للتاريخ

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  DateTime dateTime = dateFormat.parseLoose(dateString);

  Timestamp timestamp = Timestamp.fromDate(dateTime);
  return timestamp;
}

String formatFirestoreTimestamp(Timestamp timestamp) {
  // تحويل Timestamp إلى DateTime
  DateTime dateTime = timestamp.toDate();

  // تنسيق التاريخ وتحويله إلى الصيغة المطلوبة "dd/MM/yyyy"
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

  return formattedDate;
}

String insertNewLineAfterCharacterCount(String text, int charCount) {
  StringBuffer buffer = StringBuffer();
  int count = 0;

  for (int i = 0; i < text.length; i++) {
    buffer.write(text[i]);
    count++;

    if (count == charCount) {
      buffer.write('\n');
      count = 0;
    }
  }

  return buffer.toString();
}


 
  // Future<int> isWithin120Days() async {
  //   final lastDonationSnapshot = await getLastDonation();

  //   if (lastDonationSnapshot == null) {
  //     // لا توجد تبرعات سابقة
  //     return 0;
  //   } else {
  //     final storedDate = lastDonationSnapshot.toDate();

  //     final currentDate = convertStringToDateASTimestamp(DateTime.parse() ); // تفرض أن date.text يحتوي على تاريخ بتنسيق صحيح

  //     int differenceInDays = await calculateDateDifference(storedDate);
  //     print(differenceInDays);
  //     // التحقق من أن الفارق بالأيام أقل من 120 يوماً
  //     return differenceInDays <= 120 ? 1 : 0;
  //   }
  // }

  // Future<void> fetchDonationData() async {
  //   QuerySnapshot<Map<String, dynamic>> donationSnapshot =
  //       await FirebaseFirestore.instance.collection('donations').get();

  //   donationSnapshot.docs.forEach((doc) {
  //     // يمكنك هنا القيام بالتحقق من الزمن وتحديث القيمة isActive إذا كان من المرتقب أن تمر 120 يومًا.
  //     Timestamp donationTimestamp = doc['timestamp'];
  //     bool isActive = doc['isActive'];

  //     // قم بتحديث الحقل isActive بناءً على التحقق من انقضاء 120 يومًا من وقت التبرع
  //     if (isActive && is120DaysPassed(donationTimestamp)) {
  //       // تحديث الحقل isActive في Firestore
  //       doc.reference.update({'isActive': false});
  //     }
  //   });
  // }

  