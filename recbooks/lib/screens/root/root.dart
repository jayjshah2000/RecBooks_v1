import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/screens/login/login.dart';
import 'package:recbooks/states/current_user.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current user and set authstatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "Success") {
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    if (_authStatus == AuthStatus.loggedIn) {
      retVal = const HomeScreen();
    } else {
      retVal = const OurLogin();
    }

    return retVal;
  }
}
