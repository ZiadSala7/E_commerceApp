// ignore_for_file: non_constant_identifier_names, sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:level3/firebase_options.dart';
import 'package:level3/pages/ProfilePage.dart';
import 'package:level3/pages/details.dart';
import 'package:level3/pages/login.dart';
import 'package:level3/pages/sales.dart';
import 'package:level3/pages/signup.dart';
import 'package:level3/pages/snackpar.dart';
import 'package:level3/pages/verifyemail.dart';
import 'package:level3/provider/cart.dart';
import 'package:level3/provider/googlesignin.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        // ChangeNotifierProvider(create: (context) {
        //  return GoogleSignInProvider();
        // }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return ShowSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return HomeScreen(); // home() OR verify email
              } else {
                return LoginPage();
              }
            },
          )),
    );
  }
}

class Product {
  String P_name;
  double price;

  Product({required this.P_name, required this.price});
}

List AllProducts = [
  Product(P_name: "assets/img/1.webp", price: 12.00),
  Product(P_name: "assets/img/2.webp", price: 12.00),
  Product(P_name: "assets/img/3.webp", price: 12.00),
  Product(P_name: "assets/img/4.webp", price: 12.00),
  Product(P_name: "assets/img/5.webp", price: 12.00),
  Product(P_name: "assets/img/6.webp", price: 12.00),
  Product(P_name: "assets/img/7.webp", price: 12.00),
  Product(P_name: "assets/img/8.webp", price: 12.00),
  Product(P_name: "assets/img/1.webp", price: 12.00),
  Product(P_name: "assets/img/1.webp", price: 12.00),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cartt = Provider.of<Cart>(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: Column(children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Ziad Salah",
                style: TextStyle(fontSize: 22),
              ),
              accountEmail: Text(
                "Ziad@gmail.com",
                style: TextStyle(fontSize: 16),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/seen.jfif"),
                    fit: BoxFit.cover),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/img/1.webp"),
              ),
            ),
            ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
            ListTile(
                title: Text("My products"),
                leading: Icon(Icons.add_shopping_cart),
                onTap: () {}),
            ListTile(
                title: Text("About"),
                leading: Icon(Icons.help_center),
                onTap: () {}),
            ListTile(
                title: Text("Profile Page"),
                leading: Icon(Icons.person),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage()));
                }),
            ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                }),
          ]),
        ),
        appBar: AppBar(
          backgroundColor: Colors.cyan[900],
          title: Text(
            "Home",
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.amber,
                      child: Text(cartt.AddedProducts.length.toString()),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bought_Products()));
                        },
                        icon: Icon(Icons.add_shopping_cart))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Text(cartt.price.toString()),
                )
              ],
            ),
          ],
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5 / 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 33),
          itemCount: AllProducts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(127, 174, 180, 178),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              name: AllProducts[index].P_name,
                              price: AllProducts[index].price)));
                },
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Color.fromARGB(138, 125, 135, 136),
                    trailing: IconButton(
                        color: Color.fromARGB(255, 74, 98, 80),
                        onPressed: () {
                          setState(() {
                            cartt.add(AllProducts[index]);
                            cartt.price += AllProducts[index].price;
                          });
                        },
                        icon: Icon(Icons.add, color: Colors.white)),
                    leading: Text(
                      " ${AllProducts[index].price.toString()} \$",
                      style: TextStyle(color: Colors.white),
                    ),
                    title: Text(
                      "",
                    ),
                  ),
                  child: Image.asset(AllProducts[index].P_name),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
