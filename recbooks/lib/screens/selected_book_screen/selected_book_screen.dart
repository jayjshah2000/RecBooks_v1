import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/book.dart';
import 'package:recbooks/models/recommended_books.dart';
import 'package:recbooks/services/database.dart';
import 'package:recbooks/states/current_user.dart';
// import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/widgets/nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectedBookScreen extends StatefulWidget {
  final Book book;
  const SelectedBookScreen({Key? key, required this.book}) : super(key: key);

  @override
  _SelectedBookScreenState createState() => _SelectedBookScreenState();
}

class _SelectedBookScreenState extends State<SelectedBookScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   getRecommendedBookData1 = getRecommendedBookData1(widget.book.title);
  // }

  launchURL(String url) async {
    await launch(url);
  }

// void launchURL(String _url) async {
//   final result = await openUrl('https://github.com/renatoathaydes/open_url');
//   if (result.exitCode == 0) {
//     print('URL should be open in your browser');
//   } else {
//     print('Something went wrong (exit code = ${result.exitCode}): '
//         '${result.stderr}');
//   }
// }

  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String returnString;
    OurDatabase db = OurDatabase();
    String _url = 'https://www.amazon.in/s?k=' +
        widget.book.title.replaceAll(RegExp(' '), '%20') +
        "%20" +
        widget.book.author.replaceAll(RegExp(' '), '%20');
    return Scaffold(
      bottomNavigationBar: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 15, right: 5, bottom: 25),
            height: 49,
            width: MediaQuery.of(context).size.width * 0.45,
            color: Colors.transparent,
            child: TextButton(
              // color: kMainColor,
              style: TextButton.styleFrom(
                // primary: kMainColor,
                backgroundColor: kMainColor,
              ),
              onPressed: () async {
                returnString = await db
                    .addBookToBookmark(
                        _currentUser.getCurrentUser.uid, widget.book.title);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(returnString)));
              },
              child: Text(
                'Bookmark',
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor),
              ),
              // shape:
              //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          // SizedBox(width: 55),
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 25),
            height: 49,
            width: MediaQuery.of(context).size.width * 0.45,
            color: Colors.transparent,
            child: TextButton(
              // color: kMainColor,
              style: TextButton.styleFrom(
                // primary: kMainColor,
                backgroundColor: kMainColor,
              ),
              onPressed: () => launchURL(_url),
              child: Text(
                'Buy on Amazon',
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor),
              ),
              // shape:
              //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: kMainColor,
              expandedHeight: MediaQuery.of(context).size.height * 0.5,
              flexibleSpace: SizedBox(
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 62),
                        width: 172,
                        height: 225,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(widget.book.imageUrl),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 25, right: 25),
                child: SelectableText(
                  widget.book.title,
                  style: GoogleFonts.openSans(
                      fontSize: 27,
                      color: kBlackColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: Text(
                  "By " + widget.book.author,
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kGreyColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: SelectableText.rich(
                  TextSpan(
                    text:'ISBN 10:  ',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kBlackColor,
                      fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.book.isbn_10,
                        style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kGreyColor,
                      fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ) ,     
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: SelectableText.rich(
                  TextSpan(
                    text:'ISBN 13:  ',
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kBlackColor,
                      fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.book.isbn_13,
                        style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kGreyColor,
                      fontWeight: FontWeight.w400),
                      ),
                      ],),
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, left: 25),
                child: Text(
                  "Category: " + widget.book.category,
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Summary",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: kBlackColor,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      Text(
                        widget.book.summary,
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            color: kGreyColor,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recommend 1",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: kBlackColor,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                      // Text(
                      //   widget.book.summary,
                      //   style: GoogleFonts.openSans(
                      //       fontSize: 15,
                      //       color: kGreyColor,
                      //       fontWeight: FontWeight.w400),
                      // )
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 21),
                height: 240,
                child: FutureBuilder(
                  future: getRecommendedBookData1(widget.book.title),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Recommend 2",
                          style: GoogleFonts.openSans(
                              fontSize: 20,
                              color: kBlackColor,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 5),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.only(top: 21),
                height: 240,
                child: FutureBuilder(
                  future: getRecommendedBookData2(widget.book.title),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
            ]))
          ],
        ),
      ),
    );
  }
}
