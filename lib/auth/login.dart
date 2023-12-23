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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formstate,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 50,
              ),
              CustomLogoAuth(),
              Container(
                height: 20,
              ),
              Text(
                "Login",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
              ),
              Container(
                height: 4,
              ),
              Text(
                "Login To Continue Using Try App",
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                height: 20,
              ),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(height: 15),
              CustomTextField(
                  hintText: "Enter Your Email", Mycontroller: email,validator: (val){
                   if (val==""){
                    return 'Please Enter An Email';
                   }
                  },),
              Container(
                height: 15,
              ),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                height: 15,
              ),
              CustomTextField(
                  hintText: "Enter Your Password", Mycontroller: password,validator: (val){
                  if (val==""){
                    return 'Please Enter An Password';
                   }
                  }),
              Container(height: 15),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 15),
                alignment: Alignment.topRight,
                child: Text(
                  "Forget Password ?",
                ),
              ),
            ]),
          ),
          CustomButton(
              title: "Login",
              onPressed: () async {
                if (formstate.currentState!.validate()) {
                  try {
                    final credential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    Navigator.of(context).pushReplacementNamed("home");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The password provided is too weak.',
                      ).show();
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: 'The account already exists for that email.',
                      ).show();
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              }),
          Container(height: 10),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.red[200],
            textColor: Colors.white,
            onPressed: () {},
            child: Center(child: Text("Login with Google")),
          ),
          Container(height: 15),
          InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("signup");
              },
              child: Center(
                child: Text.rich(TextSpan(children: const [
                  TextSpan(text: "Don't Have An Acount ? "),
                  TextSpan(
                      text: "Register", style: TextStyle(color: Colors.orange)),
                ])),
              ))
        ]),
      ),
    );
  }
}
