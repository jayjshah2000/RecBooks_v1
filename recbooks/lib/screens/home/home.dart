import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/random_books.dart';
// import 'package:recbooks/screens/root/root.dart';
import 'package:recbooks/screens/selected_book_screen/selected_book_screen.dart';
// import 'package:recbooks/screens/login/login.dart';
import 'package:recbooks/states/current_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 25, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, ' + _currentUser.getCurrentUser.fullName.toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kGreyColor),
                  ),
                  Text(
                    'Welcome to RecBooks!',
                    style: GoogleFonts.openSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: kBlackColor),
                  ),
                ],
              )),
          Container(
            height: 39,
            margin: const EdgeInsets.only(left: 25, right: 25, top: 18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: kLightGreyColor),
            child: Stack(
              children: <Widget>[
                TextField(
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      color: kBlackColor,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 19, right: 50, bottom: 8),
                      border: InputBorder.none,
                      hintText: 'Search book..',
                      hintStyle: GoogleFonts.openSans(
                          fontSize: 12,
                          color: kGreyColor,
                          fontWeight: FontWeight.w600)),
                ),
                Positioned(
                  right: 0,
                  child: SvgPicture.asset('assets/svg/background_search.svg'),
                ),
                Positioned(
                  top: 8,
                  right: 9,
                  child:
                      SvgPicture.asset('assets/icons/icon_search_white.svg'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'New books',
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
              future: getRandomBookData(),
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
                            onTap: (){
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
                                const SizedBox(height: 5,),
                                Expanded(
                                  child: Text(
                                    snapshot.data[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: kBlackColor
                                    ),
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
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'Recommended for you',
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
                future: getRandomBookData(),
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


//Sign out button
// ElevatedButton(
//           child: const Icon(Icons.logout),
//           onPressed: () async {
//             CurrentUser _currentUser = Provider.of(context, listen: false);
//             String _returnString = await _currentUser.signOut();
//             if (_returnString == "Success") {
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const OurRoot()),
//                   (route) => false);
//             }
//           },
//         ),

//container
