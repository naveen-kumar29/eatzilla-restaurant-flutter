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
  runApp(const MaterialApp(home: PayoutScreen()));

}

class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _myAppState();
}

class _myAppState extends State<PayoutScreen> {
  var mResponse;

  Future<void> changePasswordApi() async {
    try {
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(mPayoutDetailsApiUrl),
        headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
        body: {
          'end_date': '2023-06-15',
          'start_date': '2023-06-15',
        },
      );

      if (response.statusCode == 200) {
        mResponse = json.decode(response.body);
        if (mResponse['status'] == true) {
          Global.showSnackBar(context,mResponse['message']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MoreScreen()),
          );
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
      /* Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Pending Payouts :100',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ],
            ),
*//*
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 ListView.builder(
                      itemCount: yourList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.circular(15.00),
                                ),
                                color: Colors.white54,
                                child: const SizedBox(height: 150,width: 350,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Transaction ID : Trans-39408353'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Restaurant Payout'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Transaction : Success'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Rs:100'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
               ],
             ),*//*
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15.00),
                        ),
                        color: Colors.white54,
                        child:const SizedBox(height: 150,width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction ID : Trans-39408353'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Restaurant Payout'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction : Success'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Rs:100'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15.00),
                        ),
                        color: Colors.white54,
                        child:const SizedBox(height: 150,width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction ID : Trans-39408353'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Restaurant Payout'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction : Success'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Rs:100'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15.00),
                        ),
                        color: Colors.white54,
                        child:const SizedBox(height: 150,width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction ID : Trans-39408353'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Restaurant Payout'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction : Success'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Rs:100'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15.00),
                        ),
                        color: Colors.white54,
                        child:const SizedBox(height: 150,width: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction ID : Trans-39408353'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Restaurant Payout'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Transaction : Success'),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Rs:100'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        )*/);
  }
}
