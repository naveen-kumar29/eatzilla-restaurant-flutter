import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main(){
  runApp(const MaterialApp(home:mainScreen()));
}
class mainScreen extends StatefulWidget {
  const mainScreen({super.key});

  @override
  State<mainScreen> createState() => _myAppState();
}

class _myAppState extends State<mainScreen> {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime firstDay = DateTime.now();
  DateTime endDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sample App'),
      ),
        body: TableCalendar(focusedDay: focusedDay, firstDay: firstDay, lastDay: endDay)
/*
        body: TableCalendar(focusedDay: focusedDay, firstDay: firstDay, lastDay: endDay)
*/
      /* body:  TableCalendar(
         calendarFormat: calendarFormat,
         selectedDayPredicate: (day) {
           return isSameDay(selectedDay, day);
         },
         onDaySelected: (selectedDay, focusedDay) {
           setState(() {
             selectedDay = selectedDay;
             focusedDay = focusedDay;
           });
         },
         onPageChanged: (focusedDay) {
           focusedDay = focusedDay;
         }, focusedDay: focusedDay, firstDay: firstDay, lastDay: endDay,
       ),*/
    );
  }
}