import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blood_donation/components/customButton.dart';
import 'package:blood_donation/components/customLogoAuth.dart';
import 'package:blood_donation/components/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              Form(
                key: formstate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 20),
                    const CustomLogoAuth(),
                    Container(height: 20),
                    const Text("تسجيل حساب جديد",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Container(height: 10),
                    const Text("تحتاج الى تسجيل حساب جديد لاستخدام التطبيق",
                        style: TextStyle(color: Colors.grey)),
                    Container(height: 20),
                    const Text(
                      "البريد الالكتروني",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextField(
                      hintText: "ُادخل البريد الالكتروني",
                      MyController: email,
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال البريد الالكتروني';
                        }
                      },
                    ),
                    Container(height: 10),
                    const Text(
                      "كلمة المرور",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Container(height: 10),
                    CustomTextField(
                      hintText: "ادخل كلمة المرور",
                      MyController: password,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) {
                        if (val == "") {
                          return 'الرجاء ادخال كلمة المرور';
                        }
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "نسيت كلمة المرور ؟",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                  title: "تسجيل حساب جديد",
                  onPressed: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text,
                      );
                      Navigator.of(context).pushReplacementNamed("home");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'كلمة المرور المحددة ضعيفة',
                        ).show();
                      } else if (e.code == 'email-already-in-use') {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'خطأ',
                          desc: 'هذا الحساب مسجل سابقا',
                        ).show();
                      }
                    } catch (e) {
                      print(e);
                    }
                  }),

              Container(height: 15),
              // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("login");
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "هل تملك حساب ؟ ",
                    ),
                    TextSpan(
                        text: "تسجيل دخول",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                  ])),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
