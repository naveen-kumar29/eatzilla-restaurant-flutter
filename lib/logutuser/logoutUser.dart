import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:login/common/Global.dart';
import 'package:login/loginScreen.dart';
import '../string/string.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void logOutUser(context) async {
  var mResponse;
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  final response = await http.get(
    Uri.parse(mLogoutApiUrl),
    headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
  );
  if (response.statusCode == 200) {
    mResponse = json.decode(response.body);
    if (mResponse['status'] == true) {
      sharedPreference.setBool('login',false);
      Global.showSnackBar(context, mResponse['message']);
      sharedPreference.clear();
      print('naveen${sharedPreference.getString('authToken').toString()+sharedPreference.getString('authId').toString()}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),

      );
    } else {
      Global.showSnackBar(context, mResponse['message']);
    }
  } else {
    print("error${response.statusCode}");
  }
}
