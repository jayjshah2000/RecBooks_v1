import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/search_screen/search_page.dart';
import 'package:recbooks/services/database.dart';
import 'package:recbooks/states/current_user.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
//   List<String> _suggestionListTitles = [];

//   Future<List<String>> _loadTitles() async {
//     List<String> suggestionListTitles = [];
//     await rootBundle.loadString('assets/book_titles.txt').then((q) {
//       for (String i in const LineSplitter().convert(q)) {
//         suggestionListTitles.add(i);
//       }
//     });
//     return suggestionListTitles;
//   }

//  List<String> getSuggestionsTitles(String query) {
//     List<String> matches = [];
//     matches.addAll(_suggestionListTitles);
//     matches.retainWhere((s) =>   s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
//   final TextEditingController _typeAheadControllerTitles = TextEditingController();



//   // for authors
//   List<String> _suggestionListAuthors = [];

//   Future<List<String>> _loadAuthors() async {
//     List<String> suggestionListAuthors = [];
//     await rootBundle.loadString('assets/book_author.txt').then((q) {
//       for (String i in const LineSplitter().convert(q)) {
//         suggestionListAuthors.add(i);
//       }
//     });
//     return suggestionListAuthors;
//   }

//  List<String> getSuggestionsAuthors(String query) {
//     List<String> matches = [];
//     matches.addAll(_suggestionListAuthors);
//     matches.retainWhere((s) =>   s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
//   final TextEditingController _typeAheadControllerAuthor = TextEditingController();


//   // for Category
//   List<String> _suggestionListCategory = [];

//   Future<List<String>> _loadCategory() async {
//     List<String> suggestionListCategory = [];
//     await rootBundle.loadString('assets/Category.txt').then((q) {
//       for (String i in const LineSplitter().convert(q)) {
//         suggestionListCategory.add(i);
//       }
//     });
//     return suggestionListCategory;
//   }

//  List<String> getSuggestionsCategory(String query) {
//     List<String> matches = [];
//     matches.addAll(_suggestionListCategory);
//     matches.retainWhere((s) =>   s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
//   final TextEditingController _typeAheadControllerCategory = TextEditingController();



  @override
  void initState() {
    // _setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    OurDatabase db = OurDatabase();
    return Scaffold(
      body: ListView(
        
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 25, top: 25, right:25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Profile',
                    style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kGreyColor),
                  ),
                  Text(
                    'Hi, ' + _currentUser.getCurrentUser.fullName.toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 25, right:25),
                    child: Text(
                      'Do you wish to Log Out?',
                      style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kGreyColor),
                    ),
                  ),
                ],
              )),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  CurrentUser _currentUser =
                      Provider.of(context, listen: false);
                  String _returnString = await _currentUser.signOut();
                  if (_returnString == "Success") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OurRoot()),
                        (route) => false);
                  }
                },
                child: const Icon(Icons.logout)),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 25, top: 25, right:25),
                 child: Text(
                   'Favourite Authors',
                   style: GoogleFonts.openSans(
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                       color: kGreyColor),
                 ),
               ),
            Container(
              child: Container(
                // padding: const EdgeInsets.all(8.0),
              // child: Text('Bookmark'),
              child: FutureBuilder(
                future: db.getFavAuthors(_currentUser.getCurrentUser.uid),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 7.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        // padding: const EdgeInsets.only(left: 25, right: 6),
                        itemCount: snapshot.data.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            // padding: const EdgeInsets.all(5),
                            width: 150,
                            height: 40,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.left,
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kBlackColor),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            ),

            // for Genre
            Padding(
                 padding: const EdgeInsets.only(left: 25, top: 25, right:25),
                 child: Text(
                   'Favourite Genre',
                   style: GoogleFonts.openSans(
                       fontSize: 20,
                       fontWeight: FontWeight.w600,
                       color: kGreyColor),
                 ),
               ),
            Container(
              child: Container(
                // padding: const EdgeInsets.all(8.0),
              // child: Text('Bookmark'),
              child: FutureBuilder(
                future: db.getFavGenre(_currentUser.getCurrentUser.uid),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 7.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        // padding: const EdgeInsets.only(left: 25, right: 6),
                        itemCount: snapshot.data.length,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            // padding: const EdgeInsets.all(5),
                            width: 150,
                            height: 40,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.left,
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kBlackColor),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            ),
          // ),
        ],
      ),
    );
  }
}
