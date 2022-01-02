import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:recbooks/screens/login/localwidgets/loginform.dart';

class OurLogin extends StatelessWidget {
  const OurLogin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.asset("assets/logos/RecBooks.png"),
                ),
                
                // const SizedBox(height:10),
                const OurLoginForm(),

              ],
            )
          )
        ],
      ),
    );
  }
}