// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:level3/pages/sales.dart';
import 'package:level3/provider/cart.dart';
import 'package:provider/provider.dart';



class DetailScreen extends StatefulWidget {
  final String name;
  final double price;
  const DetailScreen({super.key, required this.name, required this.price});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool IsNull = false;

  myfunc() {
    setState(() {
      IsNull = !IsNull;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(
          "Details Screen",
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
                    child: Consumer<Cart>(
                        builder: ((context, classInstancee, child) {
                      return Text(
                        "${classInstancee.AddedProducts.length}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      );
                    })),
                  ),
                  IconButton(
                      onPressed: () {
                       Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bought_Products()));
                      }, icon: Icon(Icons.add_shopping_cart))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child:
                    Consumer<Cart>(builder: ((context, classInstancee, child) {
                  return Text("${classInstancee.price.toString()} \$");
                })),
              )
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 600,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Image.asset(widget.name, fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Text(" ${widget.price.toString()} \$",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(120, 168, 9, 70),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "New",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 35,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 35,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 35,
                    ),
                    Icon(
                      Icons.star_half,
                      color: Colors.amber,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share_location_outlined,
                    size: 30,
                  ),
                ),
                Text(
                  "Location",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                margin: EdgeInsets.only(left: 10),
                width: double.infinity,
                child: Text(
                  "Details :",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 23,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes. The male gametophyte, which produces non-motile sperm, is enclosed within pollen grains; the female gametophyte is contained within the ovule. When pollen from the anther of a flower is deposited on the stigma, this is called pollination. Some flowers may self-pollinate, producing seed using pollen from the same flower or a different flower of the same plant, but others have mechanisms to prevent self-pollination and rely on cross-pollination, when pollen is transferred from the anther of one flower to the stigma of another flower on a different individual of the same species.",
                maxLines: IsNull ? null : 5,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 23,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  myfunc();
                },
                child: Text(
                  IsNull ? "Show less" : "Show more",
                  style: TextStyle(fontSize: 22),
                ))
          ]),
        ),
      ),
    );
  }
}
