import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:login/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:login/common/Global.dart';
import 'package:login/loginScreen.dart';
import 'package:login/more/MoreScreen.dart';
import '../string/string.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MaterialApp(home: FoodManagement()));

}

class FoodManagement extends StatefulWidget {
  const FoodManagement({super.key});

  @override
  State<FoodManagement> createState() => _myAppState();
}

class _myAppState extends State<FoodManagement> {
  var mResponse;

  Future<void> GetFoodList() async {
    try {
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final response = await http.get(
        Uri.parse(mGetFoodListApiUrl),
        headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
      );

      if (response.statusCode == 200) {
        mResponse = json.decode(response.body);
        if (mResponse['status'] == true) {
          print('${json.decode(response.body)}');
        }

        // Success
        print(json.decode(response.body));
      } else if(response.statusCode==401){
        sharedPreference.setBool('login',false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
      }
      else
      {
        // Error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception
      print('Exception: $e');
    }
  }
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    // Add more items as needed
  ];
  @override
  void initState() {
    GetFoodList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Payout Details'),
        ),
        body:ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: ListTile(
                  title: Text(items[index]),
                ),
              ),
            );
          },
        )
      );
  }
}
