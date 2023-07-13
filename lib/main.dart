
import 'package:flutter/material.dart';
import 'loginScreen.dart';

void main() {
  runApp(  const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:
          SplashScreen(), // Replace SplashScreen with your custom splash screen class
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool authProvider =true;

    // Add any initialization code or delay here if needed

    // Example: navigate to another screen after 2 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if(authProvider) {
        print("success");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }else{
        print(" noooo success");

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      // Customize your splash screen UI here
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/restaurant_splash.jpg'),
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Restaurant app',
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
