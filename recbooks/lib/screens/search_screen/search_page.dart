import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/profile/profile.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/search_result/search_result.dart';
import 'package:recbooks/states/current_user.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recbooks/widgets/nav_bar.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
// import 'package:barcode_scan2/barcode_scan2.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _suggestionListTitles = [];

  Future<List<String>> _loadTitles() async {
    List<String> suggestionListTitles = [];
    await rootBundle.loadString('assets/book_titles.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        suggestionListTitles.add(i);
      }
    });
    return suggestionListTitles;
  }

  List<String> getSuggestionsTitles(String query) {
    List<String> matches = [];
    matches.addAll(_suggestionListTitles);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerTitles =
      TextEditingController();

  // for authors
  List<String> _suggestionListAuthors = [];

  Future<List<String>> _loadAuthors() async {
    List<String> suggestionListAuthors = [];
    await rootBundle.loadString('assets/book_author.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        suggestionListAuthors.add(i);
      }
    });
    return suggestionListAuthors;
  }

  List<String> getSuggestionsAuthors(String query) {
    List<String> matches = [];
    matches.addAll(_suggestionListAuthors);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerAuthor =
      TextEditingController();

  // for Category
  List<String> _suggestionListCategory = [];

  Future<List<String>> _loadCategory() async {
    List<String> suggestionListCategory = [];
    await rootBundle.loadString('assets/Category.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        suggestionListCategory.add(i);
      }
    });
    return suggestionListCategory;
  }

  List<String> getSuggestionsCategory(String query) {
    List<String> matches = [];
    matches.addAll(_suggestionListCategory);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerCategory =
      TextEditingController();

  // FOR ISBN 10
  List<String> _suggestionListISBN10 = [];

  Future<List<String>> _loadISBN10() async {
    List<String> suggestionListISBN10 = [];
    await rootBundle.loadString('assets/isbn_10.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        suggestionListISBN10.add(i);
      }
    });
    return suggestionListISBN10;
  }

  List<String> getSuggestionsISBN10(String query) {
    List<String> matches = [];
    matches.addAll(_suggestionListISBN10);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerISBN10 =
      TextEditingController();

  // for ISBN 13
  List<String> _suggestionListISBN13 = [];

  Future<List<String>> _loadISBN13() async {
    List<String> suggestionListISBN13 = [];
    await rootBundle.loadString('assets/isbn_13.txt').then((q) {
      for (String i in const LineSplitter().convert(q)) {
        suggestionListISBN13.add(i);
      }
    });
    return suggestionListISBN13;
  }

  List<String> getSuggestionsISBN13(String query) {
    List<String> matches = [];
    matches.addAll(_suggestionListISBN10);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  final TextEditingController _typeAheadControllerISBN13 =
      TextEditingController();

  @override
  void initState() {
    _setup();
    super.initState();
  }

  _setup() async {
    // Retrieve the questions (Processed in the background)
    List<String> suggestionListTitles = await _loadTitles();
    List<String> suggestionListAuthors = await _loadAuthors();
    List<String> suggestionListCategory = await _loadCategory();
    List<String> suggestionListISBN10 = await _loadISBN10();
    List<String> suggestionListISBN13 = await _loadISBN13();

    // Notify the UI and display the questions
    setState(() {
      _suggestionListTitles = suggestionListTitles;
      _suggestionListAuthors = suggestionListAuthors;
      _suggestionListCategory = suggestionListCategory;
      _suggestionListISBN10 = suggestionListISBN10;
      _suggestionListISBN13 = suggestionListISBN13;
    });
  }

  final queryParameters = {};

  //
  //
  // // isbn barcode codes
  // Future<void> startBarcodeScanStream() async {
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //       '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
  //       .listen((barcode) => print(barcode));
  // }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;
  //
  //   setState(() {
  //     _scanBarcode = barcodeScanRes;
  //   });
  // }

  String barcode = "";

  Future barcodeScanning() async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = _navigateToDetail(barcode.rawContent);
        // this.barcode = barcode.rawContent;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          barcode = 'No camera permission!';
        });
      } else {
        setState(() => barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => barcode = 'Unknown error: $e');
    }
  }


  // _navigateToDetail(String title, String author, String category, String isbn10, String isbn13) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => DetailPage(title, author, category, isbn10, isbn13)),
  //   );
  //   if (result != null) {
  //     setState(() {
  //       _title = result;
  //     });
  //   }
  // }

  _navigateToDetail(String isbn_13) async {
    final result = await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResult(isbn_13:isbn_13),
                                  ),
                                );
    if (result != null) {
      setState(() {
        print(isbn_13);
        // _isbn_13 = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      // bottomNavigationBar: OurNavigationBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 25, top: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Positioned(
                    left: 25,
                    top: 35,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OurNav()),
                            (route) => false);
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: kWhiteColor),
                        child: SvgPicture.asset(
                            'assets/icons/icon_back_arrow.svg'),
                      ),
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                    Container(
                      child: ElevatedButton(
                        onPressed: barcodeScanning,
                        child: const Text(
                          "Capture Image",
                          style: TextStyle(fontSize: 20, color: kBlackColor),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(kMainColor),
                          
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10),
                    ),
                   Container(
                      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    Text(
                      barcode,
                      style: const TextStyle(fontSize: 25, color: kBlackColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Search',
                        style: GoogleFonts.montserrat(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                      ),
                    ),
                    

                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    // Type Ahead for Titles
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                        decoration: InputDecoration(
                          labelText: 'Titles',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _typeAheadControllerTitles,
                      ),
                      suggestionsCallback: (pattern) async {
                        return getSuggestionsTitles(pattern.toString());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _typeAheadControllerTitles.text = suggestion.toString();
                        queryParameters['title'] = suggestion.toString();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    // Type Ahead for Authors
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                        decoration: InputDecoration(
                          labelText: 'Authors',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _typeAheadControllerAuthor,
                      ),
                      suggestionsCallback: (pattern) async {
                        return getSuggestionsAuthors(pattern.toString());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _typeAheadControllerAuthor.text = suggestion.toString();
                        queryParameters['author'] = suggestion.toString();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    // Typeahead for category
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _typeAheadControllerCategory,
                      ),
                      suggestionsCallback: (pattern) async {
                        return getSuggestionsCategory(pattern.toString());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _typeAheadControllerCategory.text =
                            suggestion.toString();
                        queryParameters['category'] = suggestion.toString();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    TextButton(
                      // color: kMainColor,
                      style: TextButton.styleFrom(
                        // primary: kMainColor,
                        backgroundColor: kMainColor,
                      ),
                      onPressed: () {
                        print(queryParameters);
                      },
                      child: Text(
                        'Search',
                        style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                      ),
                      // shape:
                      //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    // Type Ahead for ISBN 10
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                        decoration: InputDecoration(
                          labelText: 'ISBN 10',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _typeAheadControllerISBN10,
                      ),
                      suggestionsCallback: (pattern) async {
                        return getSuggestionsISBN10(pattern.toString());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _typeAheadControllerISBN10.text = suggestion.toString();
                        queryParameters['isbn_10'] = suggestion.toString();
                      },
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    ),
                    // Type Ahead for ISBN 10
                    TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: GoogleFonts.openSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: kBlackColor),
                        decoration: InputDecoration(
                          labelText: 'ISBN 13',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _typeAheadControllerISBN13,
                      ),
                      suggestionsCallback: (pattern) async {
                        return getSuggestionsISBN13(pattern.toString());
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.toString()),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        _typeAheadControllerISBN13.text = suggestion.toString();
                        queryParameters['isbn_13'] = suggestion.toString();
                      },
                    ),
                  ]),
                ],
              )),
        ],
      ),
    );
  }
}
