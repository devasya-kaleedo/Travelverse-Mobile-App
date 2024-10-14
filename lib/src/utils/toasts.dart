import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

void toastError(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 16,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
