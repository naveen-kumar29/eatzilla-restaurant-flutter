import 'dart:convert';
import 'package:http/http.dart';
import '../../string/string.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HttpService {

  Future<List<PayoutDetails>> getPosts() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    Response res = await get(Uri.parse(mGetPayoutDetailsApiUrl),
      headers: {'authToken': sharedPreference.getString('authToken').toString(), 'authId': sharedPreference.getString('authId').toString()},

    );


    if (res.statusCode == 200) {
     var mResponse=jsonDecode(res.body);
      List<dynamic> body = mResponse[PayoutDetails.fromJson(mResponse).details];
      List<PayoutDetails> posts = body
          .map(
            (dynamic item) => PayoutDetails.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}