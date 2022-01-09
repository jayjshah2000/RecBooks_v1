import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/search_screen/search_page.dart';
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

//   _setup() async {
//     // Retrieve the questions (Processed in the background)
//     List<String> suggestionListTitles = await _loadTitles();
//     List<String> suggestionListAuthors = await _loadAuthors();
//     List<String> suggestionListCategory = await _loadCategory();

//     // Notify the UI and display the questions
//     setState(() {
//       _suggestionListTitles = suggestionListTitles;
//       _suggestionListAuthors = suggestionListAuthors;
//       _suggestionListCategory = suggestionListCategory;
//     });
//   }

  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

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
                  // Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       // Type Ahead for Titles
                  //       TypeAheadField(
                  //         textFieldConfiguration: TextFieldConfiguration(
                  //           autofocus: true,
                  //           style: GoogleFonts.openSans(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: kBlackColor),
                  //           decoration: InputDecoration(
                  //             labelText: 'Titles',
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //           ),
                  //           controller: _typeAheadControllerTitles,
                  //         ),
                  //         suggestionsCallback: (pattern) async {
                  //           return getSuggestionsTitles(pattern.toString());
                  //         },
                  //         itemBuilder: (context, suggestion) {
                  //           return ListTile(
                  //             title: Text(suggestion.toString()),
                  //           );
                  //         },
                  //         onSuggestionSelected: (suggestion) {
                  //           _typeAheadControllerTitles.text = suggestion.toString();
                  //         },
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  //       ),
                  //     // Type Ahead for Authors
                  //     TypeAheadField(
                  //         textFieldConfiguration: TextFieldConfiguration(
                  //           autofocus: true,
                  //           style: GoogleFonts.openSans(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: kBlackColor),
                  //           decoration: InputDecoration(
                  //             labelText: 'Authors',
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //           ),
                  //           controller: _typeAheadControllerAuthor,
                  //         ),
                  //         suggestionsCallback: (pattern) async {
                  //           return getSuggestionsAuthors(pattern.toString());
                  //         },
                  //         itemBuilder: (context, suggestion) {
                  //           return ListTile(
                  //             title: Text(suggestion.toString()),
                  //           );
                  //         },
                  //         onSuggestionSelected: (suggestion) {
                  //           _typeAheadControllerAuthor.text = suggestion.toString();
                  //         },
                  //       ),
                  //       Container(
                  //         padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  //       ),
                  //       // Typeahead for category
                  //       TypeAheadField(
                  //         textFieldConfiguration: TextFieldConfiguration(
                  //           autofocus: true,
                  //           style: GoogleFonts.openSans(
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //               color: kBlackColor),
                  //           decoration: InputDecoration(
                  //             labelText: 'Category',
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //           ),
                  //           controller: _typeAheadControllerCategory,
                  //         ),
                  //         suggestionsCallback: (pattern) async {
                  //           return getSuggestionsCategory(pattern.toString());
                  //         },
                  //         itemBuilder: (context, suggestion) {
                  //           return ListTile(
                  //             title: Text(suggestion.toString()),
                  //           );
                  //         },
                  //         onSuggestionSelected: (suggestion) {
                  //           _typeAheadControllerCategory.text = suggestion.toString();
                  //         },
                  //       ),
                  //       // )
                  //     ]
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 50.0),
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
          Center(
            child: Container(
              padding: const EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 50.0),
              child: TextButton(
                onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Search()),
                              (route) => false);    
                },    
                child: const Text('Search Button'),
              ),
              ),
            )
          // ),
        ],
      ),
    );
  }
}
