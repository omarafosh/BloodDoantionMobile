import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';

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

// -----------------------
Future<bool> getIsActiveValue() async {
  // الحصول على معرف المستخدم الحالي
  String? currentUserUID = FirebaseAuth.instance.currentUser?.uid;

  if (currentUserUID != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where("user_id", isEqualTo: currentUserUID)
        .get();

    // التحقق مما إذا كان هناك قيمة مخزنة في الحقل isActive
    if (snapshot.docs.isNotEmpty && snapshot.docs.first != null) {
      bool isActive = snapshot.docs.first["isActive"];
      print(isActive);
      return isActive;
    }
  }
  return false; // قيمة افتراضية في حالة عدم وجود الوثيقة أو الحقل
}

Future<Timestamp?> getLastDonation() async {
  final user_id = FirebaseAuth.instance.currentUser?.uid;
  if (user_id != null) {
    CollectionReference donations =
        FirebaseFirestore.instance.collection('donations');

    QuerySnapshot last_donate = await donations
        .where('user_id', isEqualTo: user_id)
        .orderBy("date", descending: true)
        .limit(1)
        .get();

    if (last_donate.docs.isNotEmpty) {
      return last_donate.docs.first['date'] as Timestamp;
    }
  }
  return null;
}

int calculateDateDifference(DateTime storedDate, DateTime currentDate) {
  Duration difference = currentDate.difference(storedDate);
  int daysDifference = difference.inDays.abs();
  return daysDifference;
}

Future<bool> isWithin120Days(DateTime selectedDate) async {
  final lastDonationSnapshot = await getLastDonation();
  if (lastDonationSnapshot == null) {
    return false;
  } else {
    final storedDate = lastDonationSnapshot.toDate();
    final currentDate = selectedDate;

    int differenceInDays = calculateDateDifference(storedDate, currentDate);
    print(differenceInDays);
    // التحقق من أن الفارق بالأيام أقل من 120 يوماً
    return differenceInDays <= 120;
  }
}

dynamic launchTel() async {
  Uri email = Uri(
    scheme: 'tel',
    path: "1234567890",
  );
  if (await launchUrl(email)) {
    await launchUrl(email);
  } else {
    throw "Could not launch tel:// number";
  }
}

Future<int> getUserDonationCount() async {
  String currentUserUID = FirebaseAuth.instance.currentUser?.uid ?? '';
  QuerySnapshot donationRecords = await FirebaseFirestore.instance
      .collection('donations')
      .where('user_id', isEqualTo: currentUserUID)
      .get();

  return donationRecords.docs.length;
}

Future<String> updateUserStatus() async {
  int donationsCount = await getUserDonationCount();
  String userStatus = '';

  if (donationsCount == 0) {
    userStatus = '0'; // حالة المستخدم لم يتبرع بعد
  } else if (donationsCount == 1) {
    userStatus = '1'; // حالة المستخدم بعد التبرع الأول
  } else {
    userStatus = '2'; // حالة المستخدم بعد التبرع الثاني وما بعده
  }

  return userStatus;
}
