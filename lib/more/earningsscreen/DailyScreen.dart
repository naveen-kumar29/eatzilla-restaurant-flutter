import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login/string/string.dart';

import '../../loginScreen.dart';

void main() {
  runApp(const MaterialApp(home: DailyScreen()));
}

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _myAppState();
}

class _myAppState extends State<DailyScreen> {
  var mFilterDate;
  var mResponse;
   int mTodayEarnings=0;

  @override
  void initState() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    setState(() {
      mFilterDate = formattedDate;
      DailyEarningsApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text(mFilterDate)
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getFilterDate();
                      });
                    },
                    child: Text('Change Date')
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
                child: Text('₹ ${mTodayEarnings}', style: TextStyle(fontSize: 25),)),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(child: Text('Total earnings of the day',
              style: TextStyle(fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),)),
          )
        ],
      ),

    );
  }

  getFilterDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        setState(() {
          mFilterDate = formattedDate;
          DailyEarningsApi();
        });
      });
    } else {}
  }

  Future<void> DailyEarningsApi() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
          Uri.parse(mDailyEarningsApiUrl),
          headers: {
            'authToken': sharedPreference.getString('authToken').toString(),
            'authId': sharedPreference.getString('authId').toString()
          }, body: {
            'filter_date':mFilterDate,
      }
      );
      if (response.statusCode == 200) {
          setState(() {
            mResponse = json.decode(response.body);
            mTodayEarnings=mResponse['today_earnings'];
            print('response :${mResponse}');
          });
      } else if(response.statusCode==401){
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
}