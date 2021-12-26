import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:recbooks/screens/login/login.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/states/current_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recbooks- Find your next read"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Icon(Icons.logout),
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
        ),
      ),
    );
  }
}
