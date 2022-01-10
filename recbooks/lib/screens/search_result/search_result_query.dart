import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/book.dart';
import 'package:recbooks/models/isbn_search.dart';
import 'package:recbooks/screens/profile/profile.dart';
import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/search_screen/search_page.dart';
import 'package:recbooks/screens/selected_book_screen/selected_book_screen.dart';
import 'package:recbooks/states/current_user.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:recbooks/widgets/nav_bar.dart';

class SearchResultQuery extends StatefulWidget {
  // final isbn_13;

  // var queryParameters;
  final book_title;
  final book_author;
  final isbn;
  final Category;

  SearchResultQuery({Key? key, this.book_title, this.book_author, this.isbn, this.Category}): super(key: key);

  // get queryParameters => null;

  // final String isbn_13;

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultQuery> {
  // final queryParameters = {};
  // String book_title = '';
  // String book_author = '';
  // String isbn = '';
  // String Category = '';

  @override
  Widget build(BuildContext context) {
    // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          // Positioned(
          //           left: 25,
          //           top: 35,
          //           child: GestureDetector(
          //             onTap: () {
          //               Navigator.pushAndRemoveUntil(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const OurNav()),
          //                   (route) => false);
          //             },
          //             child: Container(
          //               width: 32,
          //               height: 32,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(5),
          //                   color: kWhiteColor),
          //               child: SvgPicture.asset(
          //                   'assets/icons/icon_back_arrow.svg'),
          //             ),
          //           ),
          //         ),
          SizedBox(
            // color: Color(popularBookModel.color),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 25,
                  top: 35,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Search()),
                          (route) => false);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kWhiteColor),
                      child:
                          SvgPicture.asset('assets/icons/icon_back_arrow.svg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 0),
            child: Text(
              'Search Results',
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(top: 21),
          //   height: 240,
          //   child: FutureBuilder(
          //     // print(),
          //     future: getBookSearch(widget.book_title, widget.book_author, widget.isbn, widget.Category),
          //     builder: (context, AsyncSnapshot snapshot) {
          //       if (snapshot.data == null) {
          //         return const Center(
          //           child: CircularProgressIndicator(
          //             strokeWidth: 7.0,
          //           ),
          //         );
          //       } else {
          //         return ListView.builder(
          //             padding: const EdgeInsets.only(left: 25, right: 6),
          //             itemCount: snapshot.data.length,
          //             physics: const BouncingScrollPhysics(),
          //             scrollDirection: Axis.horizontal,
          //             itemBuilder: (context, index) {
          //               return Container(
          //                 padding: const EdgeInsets.all(5),
          //                 width: 150,
          //                 height: 200,
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     Navigator.pushReplacement(
          //                       context,
          //                       MaterialPageRoute(
          //                         builder: (context) => SelectedBookScreen(
          //                             book: snapshot.data[index]),
          //                       ),
          //                     );
          //                   },
          //                   child: Column(
          //                     children: [
          //                       Card(
          //                         elevation: 7,
          //                         child: Container(
          //                           height: 200,
          //                           decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(5),
          //                             color: kGreyColor,
          //                             image: DecorationImage(
          //                               fit: BoxFit.fill,
          //                               image: NetworkImage(
          //                                   snapshot.data[index].imageUrl),
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       const SizedBox(
          //                         height: 5,
          //                       ),
          //                       Expanded(
          //                         child: Text(
          //                           snapshot.data[index].title,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: GoogleFonts.openSans(
          //                               fontSize: 12,
          //                               fontWeight: FontWeight.w600,
          //                               color: kBlackColor),
          //                           textAlign: TextAlign.center,
          //                         ),
          //                       ),
          //                       // Flexible(
          //                       //     // fit: FlexFit.loose,
          //                       //     child: RichText(
          //                       //       overflow: TextOverflow.ellipsis,
          //                       //       text: TextSpan(text: snapshot.data[index].title,
          //                       //       style: GoogleFonts.openSans(
          //                       //           fontSize: 10,
          //                       //           fontWeight: FontWeight.w600,
          //                       //           color: kBlackColor
          //                       //         ),
          //                       //       ),
          //                       //     ),
          //                       // ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             });
          //       }
          //     },
          //   ),
          // ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            // height: 210,
            child: FutureBuilder(
                future: getBookSearch(widget.book_title, widget.book_author, widget.isbn, widget.Category),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 7.0,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 25, right: 25, left: 25),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print('ListView Tapped');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectedBookScreen(
                                      book: snapshot.data[index]),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              height: 120,
                              width: MediaQuery.of(context).size.width - 50,
                              color: kBackgroundColor,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 62,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].imageUrl),
                                        ),
                                        color: kMainColor),
                                  ),
                                  const SizedBox(
                                    width: 21,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(text: snapshot.data[index].title,
                                            style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: kBlackColor),),
                                            
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Category: "+snapshot.data[index].category,
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight. w600,
                                              color: kGreyColor),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "By "+snapshot.data[index].author,
                                          style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: kGreyColor),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
