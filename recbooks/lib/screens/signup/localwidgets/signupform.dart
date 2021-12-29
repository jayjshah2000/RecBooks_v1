// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/states/current_user.dart';
import 'package:recbooks/widgets/our_container.dart';

class OurSignUpForm extends StatefulWidget {
  const OurSignUpForm({Key? key}) : super(key: key);

  @override
  State<OurSignUpForm> createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  void _signUpUser(String email, String password, String fullName, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString = await _currentUser.signUpUser(email, password, fullName);
      if (_returnString == "Success") {
        Navigator
            .pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const OurRoot()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_returnString),
          duration: const Duration(seconds: 2),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

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
          controller: _fullNameController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: "Full name",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: "Email",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_rounded),
            hintText: "Password",
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_open),
            hintText: "Confirm password",
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(
                    _emailController.text, _passwordController.text, _fullNameController.text, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Passwords do not match"),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            style: ElevatedButton.styleFrom(
              primary: const Color.fromRGBO(3, 105, 128, 1),
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
