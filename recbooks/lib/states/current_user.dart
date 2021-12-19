import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:google_sign_in/google_sign_in.dart';

class CurrentUser extends ChangeNotifier {
  late String _uid;
  late String _email;

  String get getUid => _uid;
  String get getEmail => _email;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(String email, String password) async {
    String retVal = "Error";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _uid = _authResult.user!.uid;
      _email = _authResult.user!.email!;
      retVal = "Success";

      // retVal = true;

    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginUserWithEmail(String email, String password) async {
    String retVal = "Error";
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _uid = _authResult.user!.uid;
      _email = _authResult.user!.email!;
      retVal = "Success";
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
    String retVal = "Error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      UserCredential _authResult = await _auth.signInWithCredential(credential);

      _uid = _authResult.user!.uid;
      _email = _authResult.user!.email!;
      retVal = "Success";
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }
}
