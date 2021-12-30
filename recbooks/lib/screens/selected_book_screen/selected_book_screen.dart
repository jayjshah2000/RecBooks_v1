import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/models/book.dart';
import 'package:recbooks/models/recommended_books.dart';
// import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/widgets/nav_bar.dart';

class SelectedBookScreen extends StatefulWidget {
  final Book book;
  const SelectedBookScreen({Key? key, required this.book}) : super(key: key);

  @override
  _SelectedBookScreenState createState() => _SelectedBookScreenState();
}

class _SelectedBookScreenState extends State<SelectedBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
        height: 49,
        color: Colors.transparent,
        child: TextButton(
          // color: kMainColor,
          style: TextButton.styleFrom(
            // primary: kMainColor,
            backgroundColor: kMainColor,
          ),
          onPressed: () {},
          child: Text(
            'Bookmark',
            style: GoogleFonts.openSans(
                fontSize: 14, fontWeight: FontWeight.w600, color: kBlackColor),
          ),
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
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
                              context, MaterialPageRoute(builder: (context) => const OurNav()), (route) => false);
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
                child: Text(
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
                  "By "+widget.book.author,
                  style: GoogleFonts.openSans(
                      fontSize: 14,
                      color: kGreyColor,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 7, left: 25),
                  child: Text(
                        "Category: "+widget.book.category,
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
                    Text("Summary",style: GoogleFonts.openSans(
                      fontSize: 20,
                      color: kBlackColor,
                      fontWeight: FontWeight.w600)),
                    const SizedBox(height:5),
                    Text(widget.book.summary,style: GoogleFonts.openSans(
                      fontSize: 15,
                      color: kGreyColor,
                      fontWeight: FontWeight.w400),)
                  ],
                )
              ),
          //     Container(
          //   margin: const EdgeInsets.only(top: 21),
          //   height: 240,
          //   child: FutureBuilder(
          //     future: getRecommendedBookData(widget.book.title),
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
          //                   onTap: (){
          //                     Navigator.pushReplacement(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => SelectedBookScreen(
          //                               book: snapshot.data[index]),
          //                         ),
          //                       );
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
          //                       const SizedBox(height: 5,),
          //                       Expanded(
          //                         child: Text(
          //                           snapshot.data[index].title,
          //                           overflow: TextOverflow.ellipsis,
          //                           style: GoogleFonts.openSans(
          //                             fontSize: 12,
          //                             fontWeight: FontWeight.w600,
          //                             color: kBlackColor
          //                           ),
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
            ]))
          ],
        ),
      ),
    );
  }
}
