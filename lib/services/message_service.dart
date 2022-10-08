import 'package:flutter/material.dart';

class MessageService{
  static displaySnackbar(value, context) {
    var snackBar = SnackBar(
      content: Text(value),
      backgroundColor:  Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}