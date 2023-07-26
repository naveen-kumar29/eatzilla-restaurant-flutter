import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:login/string/string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


void main(){
  runApp(const MaterialApp(home:OngoingOrderScreen()));
}
class OngoingOrderScreen extends StatefulWidget {
  const OngoingOrderScreen({super.key});

  @override
  State<OngoingOrderScreen> createState() => _myAppState();
}

class _myAppState extends State<OngoingOrderScreen> {
  var mResponse;

  List<dynamic> data = [];
  Future<void> payOutDetails() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse(mOngoingOrdersApiUrl),
        headers: {
          'authToken': sharedPreference.getString('authToken').toString(),
          'authId': sharedPreference.getString('authId').toString()
        },body: {
        'page':'1','type':'2','lang':'en'
      }
      );
      if (response.statusCode == 200) {
        setState(() {
          // Convert the JSON response to a List or List<Map> based on your API structure.
          // data = json.decode(response.body);
          mResponse = json.decode(response.body);
            setState(() {
              data = mResponse['order_list'];
              print('naveen${data}');

            });

        });
      } else {
        print('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  void initState() {
    payOutDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: ListView.builder(
         itemCount: data.length,
         itemBuilder: (BuildContext context, int index) {
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Card(
               child: ListTile(
                 title: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5.0,5.0,5.0,0.0),
                       child: Row(
                         children: [
                           const Text('Order ID : ',style: TextStyle(color: Colors.blue)),
                           Text(data[index]['order_id'].toString()),
                         ],
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5.0,5.0,5.0,0.0),
                       child: Text('Delivery Time : ${data[index]['ordered_on'].toString()}'),
                     ),
                     const Padding(
                       padding: EdgeInsets.fromLTRB(5.0,10.0,5.0,0.0),
                       child: Text('Order type :Door Delivery',style: TextStyle(color: Colors.black)),
                     ),
                     Padding(
                       padding: const EdgeInsets.fromLTRB(5.0,10.0,5.0,0.0),
                       child: Text('₹ ${data[index]['bill_amount'].toString()}',style: TextStyle(color: Colors.blue)),
                     ),
                     const SizedBox(height: 30,),
                     const Padding(
                       padding: EdgeInsets.fromLTRB(5.0,5.0,5.0,0.0),
                       child: Row(
                         children: [
                           Text('Order Status :  ',style: TextStyle(color: Colors.black)),
                           Text('ORDER APPROVED',style: TextStyle(color: Colors.blue)),
                         ],
                       ),
                     ),

                   ],

                 ),
               ),
             ),
           );
         },
       )
    );
  }
}