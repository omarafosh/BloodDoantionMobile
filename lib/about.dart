import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Blood Donation Qatar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/logo.jpg",
              width: 250,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                textAlign: TextAlign.center,
                "هي منصة اجتماعية ذكية تفاعلية تسعى الى تعزيز الجهود و الريادة في القطاع الصحي و تقليص فجوة التواصل بين المتبرعين و بنوك الدم حتى تصبح عملية التبرع بالدم أسهل",
                style: TextStyle(
                    fontFamily: "Cairo",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            ListTile(
              trailing: Icon(
                Icons.launch,
                color: Colors.pinkAccent,
              ),
              title: Text("09799798879879",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.pink)),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
