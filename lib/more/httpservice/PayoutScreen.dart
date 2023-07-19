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
import '../../string/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HttpService.dart';
import 'User.dart';


void main() {
  runApp(const MaterialApp(home: PayoutScreen()));

}
class Post{
  final int id;
  final int restaurant_id;

  Post({required this.id, required this.restaurant_id});
}
class PayoutScreen extends StatefulWidget {
  const PayoutScreen({super.key});

  @override
  State<PayoutScreen> createState() => _myAppState();
}

class _myAppState extends State<PayoutScreen> {
  var mResponse;
/*  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<User>>(

      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<User>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }*/

/*  Future<List<Post>> changePasswordApi() async {
    try {
      SharedPreferences sharedPreference = await SharedPreferences.getInstance();
      final response = await http.post(
        Uri.parse(mPayoutDetailsApiUrl),
        headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},
      );

      if (response.statusCode == 200) {
        mResponse = json.decode(response.body);
        if (mResponse['status'] == true) {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((Post) => Post(
            id: Post['id'],
            title: Post['restaurant_id'],
          )).toList();
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
  }*/
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    // Add more items as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter - API Implementation"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        label:Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
    );
  }

  // build list view & manage states
  FutureBuilder<List<PayoutDetails>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<PayoutDetails>>(

      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<PayoutDetails>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  ListView _buildPosts(BuildContext context, List<PayoutDetails> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].details[index].id.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].status.toString()),
          ),
        );
      },
    );
  }
}