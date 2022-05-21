import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/random_books.dart';
import 'package:recbooks/models/recommended_books.dart';
import 'package:recbooks/screens/selected_book_screen/selected_book_screen.dart';
import 'package:recbooks/services/database.dart';
import 'package:recbooks/states/current_user.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    OurDatabase db = OurDatabase();
  
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Recbooks - Find your next read'),
      //   backgroundColor: kMainColor,
      // ),
      // body: Center(
        // child: Text('Bookmark'),
      //   child: FutureBuilder(
      //     future: db.getBookmarkedBooks(_currentUser.getCurrentUser.uid),
          
      //     // future: db.getBookmarkedBooks(_currentUser.getCurrentUser.uid),
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
      //             scrollDirection: Axis.vertical,
      //             itemBuilder: (context, index) {
      //               return Container(
      //                 padding: const EdgeInsets.all(5),
      //                 width: 150,
      //                 height: 40,
      //                 child: Column(
      //                   children: [
      //                     Expanded(
      //                       child: Text(
      //                         snapshot.data[index],
      //                         overflow: TextOverflow.ellipsis,
      //                         style: GoogleFonts.openSans(
      //                             fontSize: 12,
      //                             fontWeight: FontWeight.w600,
      //                             color: kBlackColor),
      //                         textAlign: TextAlign.center,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               );
      //             });
      //       }
      //     },
      //   ),
       body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          // Padding(
          //     padding: const EdgeInsets.only(left: 25, top: 25),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Text(
          //           'Hi, ' + _currentUser.getCurrentUser.fullName.toString(),
          //           style: GoogleFonts.openSans(
          //               fontSize: 14,
          //               fontWeight: FontWeight.w600,
          //               color: kGreyColor),
          //         ),
          //         Text(
          //           'Welcome to RecBooks!',
          //           style: GoogleFonts.openSans(
          //               fontSize: 22,
          //               fontWeight: FontWeight.w600,
          //               color: kBlackColor),
          //         ),
          //       ],
          //     )),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'Bookmarked By You',
              style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: kBlackColor),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            // height: 210,
            child: FutureBuilder(
                // future: getBookmarkedBooks2(),
                future: db.getBookmarkedBooks(_currentUser.getCurrentUser.uid),
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


