// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:level3/main.dart';
import 'package:level3/pages/forgetpassword.dart';
import 'package:level3/pages/signup.dart';
import 'package:level3/pages/snackpar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final password_control = TextEditingController();
  final email_control = TextEditingController();
  bool visibility = true, IsLoading = false;
  Login() async {
    setState(() {
      IsLoading = !IsLoading;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_control.text,
        password: password_control.text,
      );
      ShowSnackBar(context, "Successful Login");
      if (!mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.code);
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    setState(() {
      IsLoading = !IsLoading;
    });
  }

  Visibility_check() {
    setState(() {
      visibility = !visibility;
    });
  }

  @override
  void dispose() {
    email_control.dispose();
    password_control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: email_control,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Enter your email: ",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 189, 188, 188),
                      ),
                    ),
                    suffixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (email) {
                    return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+/.[a-zA-Z]"))
                        ? "Enter a valid email"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: password_control,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.all(15),
                    hintText: "Enter your password: ",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 169, 159, 159),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        Visibility_check();
                      },
                      icon: visibility
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Login();
                    if (!mounted) return;
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                  ),
                  child: IsLoading
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.blueGrey,
                        )
                      : Text(
                          "Login",
                          style: TextStyle(fontSize: 22),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ResetPassword()));
                  },
                  child: Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't you have an account ?",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 27),
                  child: GestureDetector(
                    onTap: () {
                      // GoogleSignInProvider.googlelogin();
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              // color: Colors.purple,
                              color: Color.fromARGB(255, 200, 67, 79),
                              width: 1)),
                      // child: SvgPicture.asset(
                      //   "assets/icons/google.svg",
                      //   color: Color.fromARGB(255, 200, 67, 79),
                      //   height: 27,
                      // ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
