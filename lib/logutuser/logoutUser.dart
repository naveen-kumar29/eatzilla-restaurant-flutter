import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/loginScreen.dart';
import '../string/string.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


void logOutUser(context) async {
  var mResponse;
  final response = await http.get(
    Uri.parse(mLogoutApiUrl),
    headers: {'authToken': mAuthToken, 'authId': mAuthId.toString()},
  );
  if (response.statusCode == 200) {
    mResponse = json.decode(response.body);
    if (mResponse['status'] == true) {
      Fluttertoast.showToast(
          msg: mResponse['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white);
      mAuthId = mResponse['authId'];
      mAuthToken = mResponse['authToken'];
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Fluttertoast.showToast(
          msg: mResponse['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[600],
          textColor: Colors.white);
    }
  } else {
    print("error${response.statusCode}");
  }
}
