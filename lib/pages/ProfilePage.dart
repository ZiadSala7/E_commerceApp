// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:level3/pages/firestoredata.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final credential = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: const Text(
          "Profile Page",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 128, 194, 248),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(20),
                    child: Text("Personal data from firebase auth",
                        style: TextStyle(fontSize: 22)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "Email :     ",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      credential!.email.toString(),
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Created data :      ",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      DateFormat("MMMM d, y")
                          .format(credential!.metadata.creationTime!)
                          .toString(),
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Last sign in :      ",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      DateFormat("MMMM d, y")
                          .format(credential!.metadata.lastSignInTime!)
                          .toString(),
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 128, 194, 248),
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.all(20),
                    child: Text("info from firebase firestore",
                        style: TextStyle(fontSize: 22)),
                  ),
                ),
                GetDataFromFirestore(
                  documentId: credential!.uid,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
