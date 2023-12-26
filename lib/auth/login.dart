// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:blood_donation/components/customLogoAuth.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Cairo'),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: ListView(children: [
              Form(
                key: formstate,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                      ),
                      CustomLogoAuth(),
                      Container(
                        height: 20,
                      ),
                      Text(
                        "تسجيل دخول",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 30),
                      ),
                      Container(
                        height: 4,
                      ),
                      Text(
                        "تحتاج الى تسجيل الدخول لاستخدام التطبيق",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        "البريد الالكتروني",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Container(height: 15),
                      CustomTextField(
                        hintText: "ادخل البريد الالكتروني",
                        keyboardType: TextInputType.emailAddress,
                        MyController: email,
                        validator: (val) {
                          if (val == "") {
                            return 'الرجاء احال البريد الالكتروني';
                          }
                        },
                      ),
                      Container(
                        height: 15,
                      ),
                      Text(
                        "كلمة المرور",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 15,
                      ),
                      CustomTextField(
                          hintText: "ادخل كلمة المرور",
                          MyController: password,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (val) {
                            if (val == "") {
                              return 'الرجاء ادخال كلمة المرور';
                            }
                          }),
                      Container(height: 15),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        alignment: Alignment.topRight,
                        child: Text(
                          "نسيت كلمة المرور",
                        ),
                      ),
                    ]),
              ),
              CustomButton(
                  title: "تسجيل الدخول",
                  onPressed: () async {
                    if (formstate.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        if (credential.user!.emailVerified) {
                          Navigator.of(context).pushReplacementNamed("home");
                        }else{
                           // ignore: use_build_context_synchronously
                           AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'الرجاء التوجه الى البريد الالكتروني الخاص بك لتفعيل الحساب',
                        ).show();
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'بيانات تسجيل الدخول خاطئة',
                        ).show();
                      }
                    }
                  }),
              Container(height: 10),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.red[200],
                textColor: Colors.white,
                onPressed: () {},
                child: Center(child: Text("تسجيل الدخول ياستخدام حساب Google")),
              ),
              Container(height: 15),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed("signup");
                  },
                  child: Center(
                    child: Text.rich(TextSpan(children: const [
                      TextSpan(text: "لا تمتلك حساب ؟ "),
                      TextSpan(
                          text: "تسجيل حساب جديد",
                          style: TextStyle(color: Colors.orange)),
                    ])),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
