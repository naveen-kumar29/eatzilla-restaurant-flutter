import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/string/string.dart';
import '../loginScreen.dart';
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

  List<dynamic> data = [];
  List<dynamic> items = [];
  List<dynamic> name = [];

  @override
  void initState() {
      payOutDetails();
    super.initState();
  }
  Future<void> payOutDetails() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse(mGetFoodListApiUrl),
        headers: {
          'authToken': sharedPreference.getString('authToken').toString(),
          'authId': sharedPreference.getString('authId').toString()
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          // Convert the JSON response to a List or List<Map> based on your API structure.
          // data = json.decode(response.body);
          mResponse = json.decode(response.body);
          data = mResponse['details'];
          print('naveen${data}');
          for (int i = 0; i < data.length; i++) {
            setState(() {
              items=data[i]['items'];
              print('naveen${items[i]['name']}');
            });
          }
        });
      } else if(response.statusCode==401) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Food Management'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
              child: SingleChildScrollView(
                child: Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 5.0),
                          child: Text(
                            items[index]['name'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
