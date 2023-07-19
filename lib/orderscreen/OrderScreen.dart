import 'package:flutter/material.dart';
import 'package:login/orderscreen/OngoingOrderScreen.dart';
import 'NewOrderScreen.dart';
import 'PastOrderScreen.dart';


void main() => runApp(OrderScreen());

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "New Order"),
                Tab(text: "Ongoing Order"),
                Tab(text: "Past Order")
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              NewOrderScreen(),
              OngoingOrderScreen(),
              PastOrderScreen()
            ],
          ),
        ),
      ),
    );
  }
}