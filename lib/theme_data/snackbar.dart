import 'package:flutter/material.dart';

simpleSnackBar(title, context) {
  final snackBar = SnackBar(
      duration: const Duration(milliseconds: 400),
      content: Text(
        title,
        textAlign: TextAlign.center,
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}