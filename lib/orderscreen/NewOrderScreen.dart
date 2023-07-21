import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(const MaterialApp(home:NewOrderScreen()));
}
class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _myAppState();
}

class _myAppState extends State<NewOrderScreen> {
  List<String> items = [
    'New Order 1',
    'New Order 2',
    'New Order 3',
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
