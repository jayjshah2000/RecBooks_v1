import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recbooks/models/user.dart';
import 'package:recbooks/services/database.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser();
  // late String _uid;
  // late String _email;
  OurUser get getCurrentUser => _currentUser;
  // String get getUid => _currentUser.uid;
  // String get getEmail => _currentUser.email;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "Error";
    try {
      User? _firebaseUser = _auth.currentUser;
      if(_firebaseUser != null){
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        retVal = "Success";
      }
      
      
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = "Error";
    OurUser _user = OurUser();
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user!.uid;
      _user.email = _authResult.user!.email;
      _user.fullName = fullName;

      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "Success") {
        retVal = "Success";
      }
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _currentUser.uid = _authResult.user!.uid;
      _currentUser.email = _authResult.user!.email!;
      // retVal = "Success";

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

      // _currentUser!.uid = _authResult.user!.uid;
      // _currentUser!.email = _authResult.user!.email!;
      // retVal = "Success";
      _currentUser = await OurDatabase().getUserInfo(_authResult.user!.uid);
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
    OurUser _user = OurUser();
    try {
      GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth =
          await _googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      UserCredential _authResult = await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo!.isNewUser) {
        _user.uid = _authResult.user!.uid;
        _user.email = _authResult.user!.email;
        _user.fullName = _authResult.user!.displayName;
        OurDatabase().createUser(_user);
      }
      // _currentUser!.uid = _authResult.user!.uid;
      // _currentUser!.email = _authResult.user!.email!;
      // retVal = "Success";
      _currentUser = await OurDatabase().getUserInfo(_authResult.user!.uid);
      retVal = "Success";
    } catch (e) {
      retVal = e.toString();
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "Error";
    try {
      await _auth.signOut();
      _currentUser = OurUser();
      // _currentUser.email = null.toString();
      retVal = "Success";
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }
}
