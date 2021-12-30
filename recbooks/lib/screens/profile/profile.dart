import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/states/current_user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
              CurrentUser _currentUser = Provider.of(context, listen: false);
              String _returnString = await _currentUser.signOut();
              if (_returnString == "Success") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const OurRoot()),
                    (route) => false);
              }
            }, 
          child: const Icon(Icons.logout))
      ),
    );
  }
}

