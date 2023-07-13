import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MaterialApp(home:SettingsScreen()));
}
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _myAppState();
}

class _myAppState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'),
      ),
    );
  }
}