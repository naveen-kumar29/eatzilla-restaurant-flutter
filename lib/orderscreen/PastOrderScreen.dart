import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:PastOrderScreen()));
}
class PastOrderScreen extends StatefulWidget {
  const PastOrderScreen({super.key});

  @override
  State<PastOrderScreen> createState() => _myAppState();
}

class _myAppState extends State<PastOrderScreen> {
  List<String> items = [
    'Past Order 1',
    'Past Order 2',
    'Past Order 3',
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}