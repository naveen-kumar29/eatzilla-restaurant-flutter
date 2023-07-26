import 'package:flutter/material.dart';
import 'package:login/more/earningsscreen/DailyScreen.dart';
import 'package:login/more/earningsscreen/MonthlyScreen.dart';
import 'package:login/more/earningsscreen/WeeklyScreen.dart';
import 'package:login/orderscreen/OngoingOrderScreen.dart';


void main() => runApp(EarningsScreen());

class EarningsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Daily"),
                Tab(text: "Weekly"),
                Tab(text: "Monthly")
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              DailyScreen(),
              WeeklyScreen(),
              MonthlyScreen()
            ],
          ),
        ),
      ),
    );
  }
}