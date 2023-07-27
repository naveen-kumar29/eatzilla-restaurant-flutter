import 'package:flutter/material.dart';
import 'package:login/loginScreen.dart';
import 'package:login/logutuser/logoutUser.dart';

import 'ChangePasswordScreen.dart';
import 'earningsscreen/EarningsScreen.dart';
import 'PayoutScreen.dart';
import 'SupportScreen.dart';
class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child:  SizedBox(
              height: 400,
              width: 350,
              child: Column(children: <Widget>[
                ListTile(   title: const Text(
                  'Payout Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const PayoutScreen()));
                  },
                ),
                const Divider(
                  height: 0.2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EarningsScreen()));
                  },
                  title: const Text(
                    'Earnings',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Divider(
                  height: 0.2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                  },
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Divider(
                  height: 0.2,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Divider(
                  height: 0.2,
                ),
                ListTile(
                  onTap: () {
                    showAlertDialog(context);
                    },
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Divider(
                  height: 0.2,
                ),
              ]),
            ),
          )),
    );
  }

}

void showAlertDialog(BuildContext context) {
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed:  () {
      Navigator.of(_dialogKey.currentContext!).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Logout"),
    onPressed:  () {

      Navigator.of(_dialogKey.currentContext!).pop();
      logOutUser(context);

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: const Text("Are you sure you want to logout"),
    actions: [
      cancelButton,
      continueButton,
    ],
    key: _dialogKey,
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

