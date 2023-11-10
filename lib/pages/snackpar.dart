// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

ShowSnackBar(BuildContext context, String txt) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 4),
    action: SnackBarAction(label: "Close", onPressed: () {}),
    content: Text(txt),
  ));
}
