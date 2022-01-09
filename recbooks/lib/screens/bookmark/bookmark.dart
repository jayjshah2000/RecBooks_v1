import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
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
      appBar: AppBar(
        title: const Text('Recbooks - Find your next read'),
        backgroundColor: kMainColor,
      ),
      body: Center(
        // child: Text('Bookmark'),
        child: FutureBuilder(
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
                      padding: const EdgeInsets.only(left: 25, right: 6),
                      itemCount: snapshot.data.length,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          width: 150,
                          height: 40,
                          child: Column(
                            children: [
                              
                              
                              Expanded(
                                child: Text(
                                  snapshot.data[index],
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
                        );
                      });
                }
              },
        ),
      ),
    );
  }
}
