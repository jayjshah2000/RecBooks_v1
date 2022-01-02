import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    // return Scaffold(
    //   body: Center(
    //     child: ElevatedButton(
    //       onPressed: () async {
    //           CurrentUser _currentUser = Provider.of(context, listen: false);
    //           String _returnString = await _currentUser.signOut();
    //           if (_returnString == "Success") {
    //             Navigator.pushAndRemoveUntil(
    //                 context,
    //                 MaterialPageRoute(builder: (context) => const OurRoot()),
    //                 (route) => false);
    //           }
    //         }, 
    //       child: const Icon(Icons.logout))
    //   ),
    // );
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kGreyColor),
                  ),
                  Text(
                    'Hi, ' + _currentUser.getCurrentUser.fullName.toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 50.0),
                    child: Text('Do you wish to Log Out?',
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kGreyColor),
                            ),
                  ),
                ],
              )),
          Center(
            child: Container(
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
          ),
        ],
      ),
    );
  }
}