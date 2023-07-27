import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login/string/string.dart';
import '../../loginScreen.dart';

void main(){
  runApp(const MaterialApp(home:WeeklyScreen()));
}
class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _myAppState();
}

class _myAppState extends State<WeeklyScreen> {
  var mFilterDate;
  var mResponse;
   int day0=0;
  late int day1;
  late int day2;
  late int day3;
  late int day4;
  late int day5;
  late int day6;
  List<dynamic> mGrafData=[];
  @override
  void initState() {
    WeeklyEarningsApi();
    super.initState();
  }
  Future<void> WeeklyEarningsApi() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
          Uri.parse(mWeeklyEarningsApiUrl),
          headers: {
            'authToken': sharedPreference.getString('authToken').toString(),
            'authId': sharedPreference.getString('authId').toString()
          }, body: {
        'filter_date':"",
      }
      );
      if (response.statusCode == 200) {
        setState(() {
          mResponse = json.decode(response.body);
          mGrafData=mResponse['graph_data'];
   /*       day0=mGrafData[0]['day'];
          day1=mGrafData[1]['day'];
          day2=mGrafData[2]['day'];
          day3=mGrafData[3]['day'];
          day4=mGrafData[4]['day'];
          day5=mGrafData[5]['day'];
          day6=mGrafData[6]['day'];*/
          print('response :${mResponse}');
          // print('response :${mGrafData[0]['total_amount'].toString()}');
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body:  Padding(
         padding: const EdgeInsetsDirectional.fromSTEB(5.0,10.0,5.0,10.0),
         child: Center(
           child: BarChart(
             BarChartData(
               barGroups: [
                 BarChartGroupData(
                   x: DateTime.monday/*int.parse(day0.toString())*/,
                   barRods: [
                     BarChartRodData(y: 5/*mGrafData[0]['total_amount']*/ , colors: [Colors.green]),
                     BarChartRodData(y: 10/*mGrafData[0]['total_orders']*/, colors: [Colors.yellow]),
                   ],
                 ),
 /*                BarChartGroupData(
                   x: DateTime.tuesday,
                   barRods: [
                     BarChartRodData(y: mGrafData[1]['total_amount'] , colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[1]['total_orders'] , colors: [Colors.yellow]),                   ],
                 ),
                 BarChartGroupData(
                   x:DateTime.wednesday,
                   barRods: [
                     BarChartRodData(y: mGrafData[2]['total_amount'], colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[2]['total_orders'], colors: [Colors.yellow]),                   ],
                 ),
                 BarChartGroupData(
                   x: DateTime.thursday,
                   barRods: [
                     BarChartRodData(y: mGrafData[3]['total_amount']as double, colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[3]['total_orders']as double, colors: [Colors.yellow]),                   ],
                 ),
                 BarChartGroupData(
                   x: DateTime.friday,
                   barRods: [
                     BarChartRodData(y: mGrafData[4]['total_amount']as double, colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[4]['total_orders']as double, colors: [Colors.yellow]),                   ],
                 ),
                 BarChartGroupData(
                   x: DateTime.saturday,
                   barRods: [
                     BarChartRodData(y: mGrafData[5]['total_amount']as double, colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[5]['total_orders']as double, colors: [Colors.yellow]),                   ],
                 ),
                 BarChartGroupData(
                   x: DateTime.sunday,
                   barRods: [
                     BarChartRodData(y: mGrafData[6]['total_amount']as double, colors: [Colors.green]),
                     BarChartRodData(y: mGrafData[6]['total_orders']as double, colors: [Colors.yellow]),                   ],
                 ),*/
               ],
               // Customize your bar chart data here
             ),
           ),
         ),
       ),
    );
  }
}