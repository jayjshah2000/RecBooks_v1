import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/book.dart';
import 'package:recbooks/models/isbn_search.dart';
import 'package:recbooks/screens/profile/profile.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/selected_book_screen/selected_book_screen.dart';
import 'package:recbooks/states/current_user.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recbooks/widgets/nav_bar.dart';

class SearchResult extends StatefulWidget {
  final String isbn_13;
  const SearchResult({Key? key, required this.isbn_13}) : super(key: key);
  
  // final String isbn_13;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final queryParameters = {};

  @override
  Widget build(BuildContext context) {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
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
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'Search Results',
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 21),
            height: 240,
            child: FutureBuilder(
              future: getISBN13Search(widget.isbn_13),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 7.0,
                    ),
                  );
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.only(left: 25, right: 6),
                      itemCount: snapshot.data.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          height: 200,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedBookScreen(
                                      book: snapshot.data[index]),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Card(
                                  elevation: 7,
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: kGreyColor,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            snapshot.data[index].imageUrl),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    snapshot.data[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kBlackColor),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // Flexible(
                                //     // fit: FlexFit.loose,
                                //     child: RichText(
                                //       overflow: TextOverflow.ellipsis,
                                //       text: TextSpan(text: snapshot.data[index].title,
                                //       style: GoogleFonts.openSans(
                                //           fontSize: 10,
                                //           fontWeight: FontWeight.w600,
                                //           color: kBlackColor
                                //         ),
                                //       ),
                                //     ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
