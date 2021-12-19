import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recbooks/widgets/our_container.dart';

class OurSignUpForm extends StatelessWidget {
  const OurSignUpForm({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OurContainer(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 20),
          child: Text(
            "Sign Up",
            style: GoogleFonts.sourceSansPro(
              color: const Color.fromARGB(255, 119, 124, 135),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "Full name",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: "Email",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_rounded),
            hintText: "Password",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_open),
            hintText: "Confirm password",
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              // ignore: avoid_print
              print("Hello");
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(3, 105, 128, 1),
              onPrimary: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            )),
        
      ],
    ));
  }
}