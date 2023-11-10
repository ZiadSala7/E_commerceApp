// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, duplicate_import, sort_child_properties_last, sized_box_for_whitespace, non_constant_identifier_names, unused_import

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  CollectionReference users = FirebaseFirestore.instance.collection('userss');
  final credential = FirebaseAuth.instance.currentUser;
  Setting(data, key) {
    final texttt = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 200,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: texttt,
                    decoration: InputDecoration(hintText: "Enter new value : "),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            users
                                .doc(credential!.uid)
                                .update({key: texttt.text});
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        )),
                  ],
                )
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('userss');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    "Name :     ",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    data['full_name'].toString(),
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Setting(data, 'full_name');
                        });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          users
                              .doc(credential!.uid)
                              .update({'full_name': FieldValue.delete()});
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Age :     ",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    data['age'].toString(),
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Setting(data, 'age');
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          users
                              .doc(credential!.uid)
                              .update({'age': FieldValue.delete()});
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "City :     ",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    data['City'].toString(),
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Setting(data, 'City');
                        });
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          users
                              .doc(credential!.uid)
                              .update({'City': FieldValue.delete()});
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
