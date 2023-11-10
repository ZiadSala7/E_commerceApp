// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, body_might_complete_normally_nullable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:level3/pages/login.dart';
import 'package:level3/pages/snackpar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailedit = TextEditingController();
  bool Isload = false;
  final _formkey = GlobalKey<FormState>();

  Resetting() async {
    setState(() {
      Isload = !Isload;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailedit.text);
      if (!mounted) return;
      ShowSnackBar(context, "Done... please, Check your email");
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.code);
    }

    setState(() {
      Isload = !Isload;
    });
  }

  @override
  void dispose() {
    emailedit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Enter your email to reset your password",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (_formkey.currentState!.validate()) {
                        Resetting();
                        if(mounted) return;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      }
                    },
                    controller: emailedit,
                    decoration: InputDecoration(
                      filled: true,
                  contentPadding: EdgeInsets.all(15),
                      hintText: "Enter Your Email: ",
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      Resetting();
                    },
                    child: Isload
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Reset password",
                            style: TextStyle(fontSize: 20),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
