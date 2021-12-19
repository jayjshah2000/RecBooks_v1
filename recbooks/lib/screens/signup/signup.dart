import 'package:flutter/material.dart';
import 'package:recbooks/screens/signup/localwidgets/signupform.dart';

class OurSignUp extends StatelessWidget {
  const OurSignUp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20,20,20,0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    BackButton(),
                  ],
                ),
                // SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,20,20,0),
                  child: Image.asset("assets/logos/RecBooks.png",height: 250,),
                ),
                
                // const SizedBox(height:10),
                const OurSignUpForm(),

              ],
            )
          )
        ],
      ),
    );
  }
}