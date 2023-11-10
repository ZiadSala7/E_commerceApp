// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:level3/main.dart';

class Cart with ChangeNotifier
{
  List AddedProducts = [];
  double price = 0;
  add(Product item){
    AddedProducts.add(item);
  }
  int len(){
    return AddedProducts.length;
  }
}