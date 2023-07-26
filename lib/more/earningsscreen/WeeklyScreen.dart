import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:WeeklyScreen()));
}
class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _myAppState();
}

class _myAppState extends State<WeeklyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(child: Text('naveen'),alignment: Alignment.center),
    );
  }
}