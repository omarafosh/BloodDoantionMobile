import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String convertDateToSTring(timeStamp) {

  return DateFormat("dd-MM-yyyy").format(timeStamp).toString();
}

DateTime convertStringToDate(dateString){

DateFormat format = DateFormat("dd/MM/yyyy");
DateTime dateTime = format.parse(dateString);
return dateTime;
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


Future<void> fetchDonationData() async {
  QuerySnapshot<Map<String, dynamic>> donationSnapshot =
      await FirebaseFirestore.instance.collection('donations').get();

  donationSnapshot.docs.forEach((doc) {
    // يمكنك هنا القيام بالتحقق من الزمن وتحديث القيمة isActive إذا كان من المرتقب أن تمر 120 يومًا.
    Timestamp donationTimestamp = doc['timestamp'];
    bool isActive = doc['isActive'];

    // قم بتحديث الحقل isActive بناءً على التحقق من انقضاء 120 يومًا من وقت التبرع
    if (isActive && is120DaysPassed(donationTimestamp)) {
      // تحديث الحقل isActive في Firestore
      doc.reference.update({'isActive': false});
    }
  });
}

// دالة للتحقق مما إذا كان قد مر 120 يومًا من وقت التبرع
bool is120DaysPassed(Timestamp donationTimestamp) {
  Timestamp currentTime = Timestamp.now();
  Duration difference = currentTime.toDate().difference(donationTimestamp.toDate());
  return difference.inDays >= 120;
}