import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:EarningsScreen()));
}
class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _myAppState();
}

class _myAppState extends State<EarningsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings'),
      ),
    );
  }
}