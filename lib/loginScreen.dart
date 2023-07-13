import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:login/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:login/common/Global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../string/string.dart';

// import 'RegisterScreen.dart';

// void main() {
//   runApp(const MaterialApp(home: LoginScreen()));
// }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _myAppState();
}

class _myAppState extends State<LoginScreen> {
  TextEditingController mEmail = TextEditingController();
  TextEditingController password = TextEditingController();
  var mResponse;

  Future<void> loginApi() async {
    try {
      final response = await http.post(
        Uri.parse(mLoginApiUrl),
        body: {
          'device_token': mDeviceToken,
          'device_type': mDeviceType,
          'email': mEmail.text,
          'lang': mLanguage,
          'password': password.text,
        },
      );

      if (response.statusCode == 200) {
        mResponse = json.decode(response.body);
        Global.showSnackBar(context,mResponse['message']);
        if (mResponse['status'] == true) {
          SharedPreferences sharedPreference = await SharedPreferences.getInstance();
          sharedPreference.setString('authId', mResponse['authId'].toString());
          sharedPreference.setString('authToken', mResponse['authToken']);
          sharedPreference.setBool('login',true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }

        // Success
        print(json.decode(response.body));
      } else {
        // Error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Image(
            image: AssetImage('assets/images/restaurant_login_image.jpg'),
            fit: BoxFit.fill,
            height: 200,
            width: 500,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 30.0),
            child: Text('Login',
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                          color: Colors.blueAccent,
                          offset: Offset(2, 1),
                          blurRadius: 10)
                    ],
                    fontSize: 30.0,
                    color: Colors.blue)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
            child: TextField(
              controller: mEmail,
              decoration: const InputDecoration(
                  labelText: 'Enter Your Email', border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
            child: TextField(
              controller: password,
              decoration: const InputDecoration(
                  labelText: 'Enter Your Password',
                  border: OutlineInputBorder()),
            ),
          ),
        /*  const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 50.0, 0.0),
                child: Text(
                  'Forget Password ?',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),*/
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 0.0, 50.0, 0.0),
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                  onPressed: () {
                    if (mEmail.text.isEmpty && password.text.isEmpty) {
                      Global.showSnackBar(context,'Enter your email id');
                    } else if (mEmail.text.isEmpty) {
                      Global.showSnackBar(context,'Enter your email id');
                    } else if (password.text.isEmpty) {
                      Global.showSnackBar(context,'Enter your password');
                    } else if (mEmail.text.isNotEmpty &&
                        password.text.isNotEmpty) {
                      loginApi();
                    }
                  },
                  child: const Text('Login ')),
            ),
          ),
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(50.0, 10.0, 50.0, 0.0),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account?',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Sign up',
                            style: const TextStyle(
                                color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const RegisterScreen()),
                                );
                              })
                      ]),
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
