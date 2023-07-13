import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/logutuser/logoutUser.dart';
import 'package:login/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginScreen.dart';
import '../string/string.dart';
import 'package:login/common/Global.dart';


void main() {
  runApp(const MaterialApp(home: DiscountScreen()));
}

class DiscountScreen extends StatefulWidget {
  const DiscountScreen({super.key});

  @override
  State<DiscountScreen> createState() => _myAppState();
}

class _myAppState extends State<DiscountScreen> {
  int selectedValue = 1;
  TextEditingController targetAmount = TextEditingController();
  TextEditingController offerAmount = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  void getDiscount(context) async {
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
  @override
  void initState() {
    super.initState();
      getDiscount(context);
    selectedValue = 1; // Set initial selected value
  }

  var name;
  Future<void> postData() async {
    try {
    /*  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
      sharedPreference.getAuthId();
      sharedPreference.getAuthToken();*/
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(mDiscountApiUrl),
        headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
        body: {
            'discount_type': selectedValue.toString(),
            'offer_amount': offerAmount.text,
            'offer_type': '1',
            'offer_value': '100',
            'target_amount': targetAmount.text,
        },
      );
      print(offerAmount);
      print(targetAmount);
      print(selectedValue);

      if (response.statusCode == 200) {
        name = json.decode(response.body);
        Global.showSnackBar(context,name['message']);
        // Success
        print(json.decode(response.body));
      } else if(response.statusCode == 401) {
        sharedPreference.setBool('login',false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }else {
        // Error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception
      print('Exception: $e');
    }
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discount'),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: SizedBox(
                  height: 650,
                  width: 350,
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(30.00, 30.00, 0.00, 0.00),
                        child: Row(
                          children: [
                            Column(children: <Widget>[
                              Text("Discount eligibility",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                        EdgeInsetsDirectional.fromSTEB(30.00, 10.00, 0.00, 0.00),
                        child: Row(
                          children: [
                            Column(children: <Widget>[
                              Text("Choose your preferred discount type",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black54)),
                            ]),
                          ],
                        ),
                      ),
                      RadioListTile(
                        title: const Text('Percentage',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        value: 1,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          handleRadioValueChanged(value!);
                        },
                      ),
                      RadioListTile(
                        title: const Text('Flat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        value: 2,
                        groupValue: selectedValue,
                        onChanged: (value) {
                          handleRadioValueChanged(value!);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.00, 40.00, 0.00, 0.00),
                        child: Row(
                          children: [
                            Column(children: <Widget>[
                              Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: SizedBox(
                                  height: 300,
                                  width: 320,
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.00, 10.00, 0.00, 0.00),
                                    child: Column(
                                      children: <Widget>[
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  20.00, 10.00, 0.00, 0.00),
                                              child: Text("Target Amount ",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  20.00, 10.00, 5.00, 0.00),
                                              child: Text(
                                                  "How much Maximum Amount do you want to give?",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.black54)),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              20.00, 10.00, 20.00, 0.00),
                                          child: TextField(
                                            controller: targetAmount,
                                            decoration: const InputDecoration(
                                                labelText: "Target Amount",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  20.00, 20.00, 0.00, 0.00),
                                              child: Text("Offer Percentage",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                  20.00, 10.00, 0.00, 0.00),
                                              child: Text(
                                                  "What is the offer for each order?",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontStyle: FontStyle.normal,
                                                      color: Colors.black54)),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              20.00, 10.00, 20.00, 0.00),
                                          child: TextField(
                                            controller: offerAmount,
                                            decoration: const InputDecoration(
                                                labelText: "Offer Amount",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ],
                        ),
                      ),
                      Padding(
                          padding:  const EdgeInsetsDirectional.fromSTEB(
                              0.00, 40.00, 0.00, 0.00),
                          child: SizedBox(
                            height: 35,
                            width: 300,
                            child: ElevatedButton(
                                onPressed: (){
                                  postData();
                                },
                                child: const Text("UPDATE")),
                          )),
                    ],
                  ),
                ),
              ))),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    offerAmount.dispose();
    targetAmount.dispose();
  }

  void showSnackBars() {
    final snackBar = const SnackBar(
      content: Text('This is a SnackBar'),
      duration: Duration(seconds: 2),
    );

    // Show the SnackBar using the ScaffoldMessenger
    final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
