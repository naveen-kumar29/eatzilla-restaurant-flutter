import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  var fromDate;
  var toDate;
@override
  void initState() {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  setState(() {
    fromDate = formattedDate;
    toDate = formattedDate;
  });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discount'),
      ),
      // body: TableCalendar(focusedDay: focusedDay, firstDay: firstDay, lastDay: endDay)
      body: Column(
        children: [
          _dateSelectionWidget(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: const Text('Apply Filter',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),color: Colors.black12),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10.0,5.0,0.0,5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TotalOrders',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),color: Colors.black12),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10.0,5.0,0.0,5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TotalEarnings',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 100,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),color: Colors.black12),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10.0,5.0,0.0,5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AcceptedOrders',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        Text('',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 2 - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),color: Colors.black12),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RejectedOrders',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _dateSelectionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text('From Date', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 6),
            InkWell(
              onTap: getFromDate,
              child:  Row(children: [
                Text(fromDate,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_drop_down)
              ]),
            ),
            Container(
              width: 130,
              height: 1,
              color: Colors.black,
            )
          ],
        ),
        Column(
          children: [
            const Text('To Date',
                style: TextStyle(fontSize: 18, fontFamily: 'Jost')),
            const SizedBox(height: 6),
            InkWell(
              onTap: getToDate,
              child:  Row(children: [
                Text(toDate,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w500)),
                const Icon(Icons.arrow_drop_down)
              ]),
            ),
            Container(
              width: 130,
              height: 1,
              color: Colors.black,
            )
          ],
        )
      ],
    );
  }


  getFromDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        fromDate = formattedDate;
      });
    } else {}
  }

  getToDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateFormat('yyyy-MM-dd').parse(fromDate),
        firstDate: DateFormat('yyyy-MM-dd').parse(fromDate),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        toDate = formattedDate;
      });
    } else {}
  }
}