import 'dart:developer';
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
       body: Container(child: Text('naveen'),alignment: Alignment.center),
    );
  }
}