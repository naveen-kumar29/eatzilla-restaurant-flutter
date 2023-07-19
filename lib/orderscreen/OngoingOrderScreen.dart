import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:OngoingOrderScreen()));
}
class OngoingOrderScreen extends StatefulWidget {
  const OngoingOrderScreen({super.key});

  @override
  State<OngoingOrderScreen> createState() => _myAppState();
}

class _myAppState extends State<OngoingOrderScreen> {
  List<String> items = [
    'Ongoing Order 1',
    'Ongoing Order 2',
    'Ongoing Order 3',
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       body: ListView.builder(
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