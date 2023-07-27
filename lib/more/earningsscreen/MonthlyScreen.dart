import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:MonthlyScreen()));
}
class MonthlyScreen extends StatefulWidget {
  const MonthlyScreen({super.key});

  @override
  State<MonthlyScreen> createState() => _myAppState();
}

class _myAppState extends State<MonthlyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: BarChart(
           BarChartData(
             barGroups: [
               BarChartGroupData(
                 x: 0,
                 barRods: [
                   BarChartRodData(y: 8, colors: [Colors.blue]),
                 ],
               ),
               BarChartGroupData(
                 x: 1,
                 barRods: [
                   BarChartRodData(y: 5, colors: [Colors.green]),
                 ],
               ),
               BarChartGroupData(
                 x: 2,
                 barRods: [
                   BarChartRodData(y: 10, colors: [Colors.red]),
                 ],
               ),
             ],
             // Customize your bar chart data here
           ),
         ),
       ),
    );
  }
}