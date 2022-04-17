// import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recbooks/models/recommended_books.dart';
import 'package:recbooks/models/user.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
// import 'package:recbooks/states/current_user.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recbooks/models/book.dart';

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

  // Bookmarking or liking a book
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
    // print("\n\n\n\n\n\n\n\n\n" + retVal.toString()+"\n\n\n\n\n\n\n\n\n");
    return retVal;
  }

  Future getBookmarkedBooks2(String? uid) async {
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
    var hostingProviderList = [
      'namanshah0008.pythonanywhere.com',
      'finalyearprojectapi.herokuapp.com'
    ];
    var recommendationType = ['recommend1'];
    List<Book> recommendedBooks = [];
    retVal.shuffle();
    var l = 0;
    if (retVal.length >= 2) {
      l = 2;
    } else {
      l = retVal.length;
    }
    for (var i = 0; i <= l; i++) {
      var queryParameters = {'title': retVal[i]};
      var response = await http.get(Uri.https(hostingProviderList[0],
          randomChoice(recommendationType), queryParameters));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['result'].length == 5) {
          for (var i in jsonData['result']) {
            Book book = Book(
                i["book_title"],
                i["book_author"],
                i["Category"],
                i["Summary"],
                i["publisher"],
                i["img_l"],
                i["rating"],
                i['isbn_10'],
                i['isbn_13'],
                i['year']);
            recommendedBooks.add(book);
          }
          print("\n\n\n\n\n\n\n\n\n" + retVal[i].toString() + "\n\n\n\n\n\n\n\n\n");
          return recommendedBooks;
        } else {
          print("Length less than 5, so not adding to the list.\n");
        }
        ;
      } else {
        // print('Request failed with status: ${response.statusCode}.');
        print('Request failed with status');
      }
    }
    return recommendedBooks;
  }

  // for adding and retrieving Fav authors
  Future<String> addAuthorToDatabase(String? uid, String title) async {
    String retVal = "Error";
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      List toBeAdded = _docSnapshot.get("favAuthor");
      if (toBeAdded.contains(title)) {
        retVal = "Author already liked";
      } else {
        toBeAdded.add(title);
        _firestore
            .collection("users")
            .doc(uid)
            .update({"favAuthor": toBeAdded});
        retVal = "Author added successfully";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future getFavAuthors(String? uid) async {
    var retVal = [];
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal = _docSnapshot.get("favAuthor");
      // retVal.likedBooks = _docSnapshot.get("likedBooks");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    print("\n\n\n\n\n\n\n\n\n" + retVal.toString() + "\n\n\n\n\n\n\n\n\n");
    return retVal;
  }

  // for adding and retrieving Fav Genre
  Future<String> addGenreToDatabase(String? uid, String title) async {
    String retVal = "Error";
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      List toBeAdded = _docSnapshot.get("favGenre");
      if (toBeAdded.contains(title)) {
        retVal = "Genre already liked";
      } else {
        toBeAdded.add(title);
        _firestore.collection("users").doc(uid).update({"favGenre": toBeAdded});
        retVal = "Genre added successfully";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future getFavGenre(String? uid) async {
    var retVal = [];
    try {
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal = _docSnapshot.get("favGenre");
      // retVal.likedBooks = _docSnapshot.get("likedBooks");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // print("\n\n\n\n\n\n\n\n\n" + retVal.toString()+"\n\n\n\n\n\n\n\n\n");
    return retVal;
  }
}
