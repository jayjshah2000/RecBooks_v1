// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recbooks/models/user.dart';
// import 'package:recbooks/states/current_user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "Error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
        'likedBooks': [],
      });
      retVal = "Success";
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String? uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.get("fullName");
      retVal.email = _docSnapshot.get("email");
      retVal.accountCreated = _docSnapshot.get("accountCreated");
      // retVal.likedBooks = _docSnapshot.get("likedBooks");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }

  Future<String> addBookToBookmark(String? uid, String title) async {
    String retVal = "Error";
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      List toBeAdded = _docSnapshot.get("likedBooks");
      if (toBeAdded.contains(title)) {
        retVal = "Already added book to liked books";
      } else {
        toBeAdded.add(title);
        _firestore
            .collection("users")
            .doc(uid)
            .update({"likedBooks": toBeAdded});
        retVal = "Book added successfully";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future getBookmarkedBooks(String? uid) async {
    var retVal = [];
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal = _docSnapshot.get("likedBooks");
      // retVal.likedBooks = _docSnapshot.get("likedBooks");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return retVal;
  }
}
