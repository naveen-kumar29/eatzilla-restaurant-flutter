import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:login/HomeScreen.dart';
import 'package:login/loginScreen.dart';
import 'discount/DiscountScreen.dart';
import 'foodmanagement/foodmanagement.dart';
import 'mainScreen/mainScreen.dart';
import 'more/MoreScreen.dart';
import 'orderscreen/OrderScreen.dart';

void main() {
  runApp(
      const MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _myAppState();
}

class _myAppState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    const mainScreen(),
    const FoodManagement(),
          OrderScreen(),
    const DiscountScreen(),
    const MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

          // currentIndex: 0,
          fixedColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.business, color: Colors.black),
                label: 'Business',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: 'Management',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.no_food, color: Colors.black),
                label: 'Order',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.discount, color: Colors.black),
                label: 'Discount',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.more, color: Colors.black),
                label: 'More',
                backgroundColor: Colors.white)
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
