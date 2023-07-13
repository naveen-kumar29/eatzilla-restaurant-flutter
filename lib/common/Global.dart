import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global{
  static void showSnackBar(BuildContext context,String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${text}'),
        duration: Duration(seconds: 2),
        backgroundColor: (Colors.blue),
      ),
    );
  }
}