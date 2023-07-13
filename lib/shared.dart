import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';


class sharedPreference{
  static Future<String> getAuthId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authId') ?? "";
  }
  static Future setAuthId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('authId', "");
  }  static Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken') ?? "";
  }
  static Future setAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('authToken', "");
  }
 static  getHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('authId');
    prefs.getString('authToken');
  }

}
