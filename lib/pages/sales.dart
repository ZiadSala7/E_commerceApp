// ignore_for_file: sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';
import 'package:level3/provider/cart.dart';
import 'package:provider/provider.dart';

class Bought_Products extends StatefulWidget {
  const Bought_Products({super.key});

  @override
  State<Bought_Products> createState() => _Bought_ProductsState();
}

class _Bought_ProductsState extends State<Bought_Products> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: const Text(
          "My Products",
          style: TextStyle(fontSize: 24),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.amber,
                    child: Text(
                      cart.AddedProducts.length.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(cart.price.toString()),
              )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: cart.AddedProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(cart.AddedProducts[index].P_name),
                        subtitle: Text("${cart.AddedProducts[index].price}"),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(cart.AddedProducts[index].P_name),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                cart.price -= cart.AddedProducts[index].price;
                                cart.AddedProducts.remove(
                                    cart.AddedProducts[index]);
                              });
                            },
                            icon: const Icon(Icons.remove)),
                      ),
                    );
                  }),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Pay \$${cart.price}",
              style: const TextStyle(fontSize: 19),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.amber),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ],
      ),
    );
  }
}
