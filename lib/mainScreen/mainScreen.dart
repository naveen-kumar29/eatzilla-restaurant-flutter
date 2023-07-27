import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login/string/string.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import '../common/Global.dart';
import '../loginScreen.dart';

void main() {
  runApp(const MaterialApp(home: mainScreen()));
}

class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _myAppState();
}

class _myAppState extends State<mainScreen> {
  late String fromDate;
  late String toDate;
  int mTotalOrders=0;
  int mTotalEarnings=0;
  int mAcceptOrders=0;
  int mRejectedOrders=0;

  void getPayoutDetails(context) async {
    var mResponse;
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(mGetPayoutDetailsApiUrl),
      headers: {
        'authToken': sharedPreference.getString('authToken').toString(),
        'authId': sharedPreference.getString('authId').toString()
      },
      body: {
        'end_date': toDate,
        'start_date': fromDate,
      },
    );
    if (response.statusCode == 200) {
      mResponse = json.decode(response.body);
      if (mResponse['status'] == true) {
        mTotalOrders = mResponse['total_orders'];
        mTotalEarnings = mResponse['total_earnings'];
        mAcceptOrders = mResponse['accept_orders'];
        mRejectedOrders = mResponse['denied_orders'];
      } else {
        Global.showSnackBar(context, mResponse['message']);
      }
    } else if(response.statusCode==401){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }else {
      print("error${response.statusCode}");
    }
  }

  @override
  void initState() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    setState(() {
      fromDate = formattedDate;
      toDate = formattedDate;
      getPayoutDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          _dateSelectionWidget(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                getPayoutDetails(context);
              });
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: const Text('Apply Filter',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12),
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Orders',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(mTotalOrders.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12),
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Earnings',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(mTotalEarnings.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12),
                  child:  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Accepted Orders',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(mAcceptOrders.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black12),
                  child:  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  Text(
                          'Rejected Orders',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          mRejectedOrders.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _dateSelectionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text('From Date', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 6),
            InkWell(
              onTap: getFromDate,
              child: Row(children: [
                Text(fromDate,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_drop_down)
              ]),
            ),
            Container(
              width: 130,
              height: 1,
              color: Colors.black,
            )
          ],
        ),
        Column(
          children: [
            const Text('To Date',
                style: TextStyle(fontSize: 18, fontFamily: 'Jost')),
            const SizedBox(height: 6),
            InkWell(
              onTap: getToDate,
              child: Row(children: [
                Text(toDate,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_drop_down)
              ]),
            ),
            Container(
              width: 130,
              height: 1,
              color: Colors.black,
            )
          ],
        )
      ],
    );
  }

  getFromDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        fromDate = formattedDate;
      });
    } else {}
  }

  getToDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateFormat('yyyy-MM-dd').parse(fromDate),
        firstDate: DateFormat('yyyy-MM-dd').parse(fromDate),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        toDate = formattedDate;
      });
    } else {}
  }
}
