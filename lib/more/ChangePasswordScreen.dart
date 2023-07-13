import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:login/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:login/common/Global.dart';
import 'package:login/loginScreen.dart';
import 'package:login/more/MoreScreen.dart';
import '../string/string.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MaterialApp(home: ChangePasswordScreen()));
}

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _myAppState();
}

class _myAppState extends State<ChangePasswordScreen> {
  TextEditingController mOldPassword = TextEditingController();
  TextEditingController mNewPassword = TextEditingController();
  TextEditingController mConfirmPassword = TextEditingController();
  var mResponse;

  Future<void> changePasswordApi() async {
    try {
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(mChangePasswordApiUrl),
        headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
        body: {
          'new_password': mOldPassword.text.toString(),
          'old_password': mNewPassword.text.toString(),
        },
      );

      if (response.statusCode == 200) {
        mResponse = json.decode(response.body);
        if (mResponse['status'] == true) {
          Global.showSnackBar(context,mResponse['message']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MoreScreen()),
          );
        }

        // Success
        print(json.decode(response.body));
      } else if(response.statusCode==401){
      sharedPreference.setBool('login',false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
    }
      else
       {
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
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
          child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 450,
          width: 350,
          child: Column(children: <Widget>[
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 50.0, 20.0, 0.0),
              child: TextField(
                controller: mOldPassword,
                decoration: const InputDecoration(
                    labelText: 'Old Password', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              child: TextField(
                controller: mNewPassword,
                decoration: const InputDecoration(
                    labelText: 'New Password', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
              child: TextField(
                controller: mConfirmPassword,
                decoration: const InputDecoration(
                    labelText: 'ConFirm Password',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (mOldPassword.text.isEmpty &&
                      mNewPassword.text.isEmpty &&
                      mConfirmPassword.text.isEmpty) {
                    Global.showSnackBar(context,'Enter your old Password');
                  }else if(mOldPassword.text.isEmpty){
                    Global.showSnackBar(context,'Enter your old Password');
                  }else if(mNewPassword.text.isEmpty){
                    Global.showSnackBar(context,'Enter your new Password');
                  }else if(mConfirmPassword.text.isEmpty){
                    Global.showSnackBar(context,'Enter your confirm Password');
                  }else if(mOldPassword.text.isNotEmpty &&
                      mNewPassword.text.isNotEmpty &&
                      mConfirmPassword.text.isNotEmpty){
                    if(mNewPassword.text==mConfirmPassword.text){
                      changePasswordApi();
                    }else{
                      Global.showSnackBar(context,'Confirm Password is not correct');
                    }
                  }
                },
                child: const Text('Change Password'))
          ]),
        ),
      )),
    );
  }
}
