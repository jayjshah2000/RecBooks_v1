// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/screens/signup/signup.dart';
import 'package:recbooks/states/current_user.dart';
import 'package:recbooks/widgets/our_container.dart';

import 'package:google_fonts/google_fonts.dart';

// import 'package:recbooks/widgets/our_container.dart';
enum loginType {
  email,
  google,
}

class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  State<OurLoginForm> createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _loginUser(
      {@required loginType? type,
      String? email,
      String? password,
      BuildContext? context}) async {
    CurrentUser _currentUser =
        Provider.of<CurrentUser>(context!, listen: false);
    try {
      String _returnString = "Error";
      switch (type) {
        case loginType.email:
          _returnString =
              await _currentUser.loginUserWithEmail(email!, password!);
          break;
        case loginType.google:
          _returnString = await _currentUser.loginUserWithGoogle();
          break;
        default:
      }

      if (_returnString == "Success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
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

  Widget _googleButton() {
    return SignInButton(Buttons.Google, onPressed: () {
      _loginUser(type: loginType.google, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 20),
          child: Text(
            "Login",
            style: GoogleFonts.sourceSansPro(
              color: const Color.fromARGB(255, 119, 124, 135),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
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
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_rounded),
            hintText: "Password",
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              _loginUser(
                  type: loginType.email,
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context);
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
        TextButton(
          onPressed: () {
            
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OurSignUp()));
          },
          child: const Text.rich(
            TextSpan(
              text: "Don't have an account? ",
              children: <TextSpan>[
                TextSpan(
                  text: "Sign up here",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        _googleButton(),
      ],
    ));
  }
}
