// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, unused_local_variable, use_build_context_synchronously, unused_field, avoid_print, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:level3/pages/login.dart';
import 'package:level3/pages/snackpar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  final name_control = TextEditingController();
  final age_control = TextEditingController();
  final address_control = TextEditingController();
  final email_control = TextEditingController();
  final password_control = TextEditingController();
  bool IsLoading = false;
  bool visibility = true;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasDigits = false;
  bool hasSpecialCharacters = false;
  bool hasMin8Characters = false;

  CloudFirestore(credential) {
    CollectionReference users = FirebaseFirestore.instance.collection('userss');
    return users
        .doc(credential.user.uid)
        .set({
          'full_name': name_control.text,
          'age': age_control.text,
          'City': address_control.text,
          'email': email_control.text
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Register() async {
    setState(() {
      IsLoading = !IsLoading;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email_control.text,
        password: password_control.text,
      );
      CloudFirestore(credential);
      ShowSnackBar(context, "Successful Registering");
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.code);
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    setState(() {
      IsLoading = !IsLoading;
    });
  }

  CheckPassword(String password) {
    setState(() {
      password.contains(RegExp(r'[A-Z]'))
          ? hasUppercase = true
          : hasUppercase = false;
      password.contains(RegExp(r'[0-9]'))
          ? hasDigits = true
          : hasDigits = false;
      password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))
          ? hasSpecialCharacters = true
          : hasSpecialCharacters = false;
      password.contains(RegExp(r'.{8,}'))
          ? hasMin8Characters = true
          : hasMin8Characters = false;
      password.contains(RegExp(r'[a-z]'))
          ? hasLowercase = true
          : hasLowercase = false;
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
    name_control.dispose();
    age_control.dispose();
    address_control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name_control,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "Enter your Name: ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 189, 188, 188),
                            ),
                          ),
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: age_control,
                        obscureText: false,
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                            hintText: "Enter your age: ",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 189, 188, 188),
                              ),
                            ),
                            suffixIcon: Icon(Icons.group_remove_rounded)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: address_control,
                        obscureText: false,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "Enter your city: ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 189, 188, 188),
                            ),
                          ),
                          suffixIcon: Icon(Icons.location_on),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (email) {
                          return email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+/.[a-zA-Z]"))
                              ? "Enter a valid email"
                              : null;
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
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          return value!.length < 8
                              ? "Password must have at least 8 characters"
                              : null;
                        },
                        onChanged: (password) {
                          CheckPassword(password);
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: password_control,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: visibility,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(15),
                          hintText: "Enter your password: ",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 189, 188, 188),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          color:
                              hasMin8Characters ? Colors.green : Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "At least 8 chars",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          color: hasSpecialCharacters
                              ? Colors.green
                              : Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Has a special character",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 17,
                    ),
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          color: hasUppercase ? Colors.green : Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Has Uppercase letter",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                          color: hasLowercase ? Colors.green : Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Has Lowercase letter",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle,
                          color: hasDigits ? Colors.green : Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "At least 1 number",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (hasDigits &&
                          hasLowercase &&
                          hasMin8Characters &&
                          hasSpecialCharacters &&
                          hasUppercase) {
                        await Register();
                        if (!mounted) return;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    },
                    child: IsLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.blueGrey,
                          )
                        : Text(
                            "Sign up",
                            style: TextStyle(fontSize: 22),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do you have an account ?",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
