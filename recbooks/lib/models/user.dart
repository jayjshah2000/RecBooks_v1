// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;
  List? likedBooks;

  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.likedBooks,
  });
}
