import 'package:blood_donation/auth/login.dart';
import 'package:blood_donation/auth/signup.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: const Text(
              'حياة بدمك',
              style: TextStyle(color: Colors.white, fontFamily: "Cairo"),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/logo.jpg",
                  width: 150,
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        "هي منصة اجتماعية ذكية تفاعلية تسعى الى تعزيز الجهود و الريادة في القطاع الصحي و تقليص فجوة التواصل بين المتبرعين و بنوك الدم حتى تصبح عملية التبرع بالدم أسهل",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                                  SizedBox(height: 20,),
                    Divider(
                      // Divider widget
                      height: 20, // Height of the divider
                      thickness: 2, // Thickness of the line
                      color: Colors.red, // Color of the line
                      indent: 20, // Indentation from the left
                      endIndent: 20, // Indentation from the right
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        "عزيزي المتبرع عند تسجيل العضوية في منصة حياة بدمك سوف تحصل على العضوية البرونزية و بعد التبرع الأول تنتقل الى العضوية الفضية التي ترشحك لدخول السحب على رحلة عمرة و عند التبرع الثاني تنتقل للعضة الذهبية التي سوف ترشحك لرحلة حج",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 14.0,
                            color: Colors.grey)),
                  ],
                ),
                      SizedBox(height: 20,),
                ListTile(
                  title: Column(children: [
                    CustomButton(
                      title: "تسجيل عضوية",
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => SignUp()));
                      },
                    ),
                    CustomButton(
                      title: "تسجيل دخول ",
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
