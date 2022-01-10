import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/bookmark/bookmark.dart';
import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/screens/profile/profile.dart';
import 'package:recbooks/screens/search_screen/search_page.dart';

class OurNav extends StatefulWidget {
  final int selectedIndex;
  const OurNav({Key? key, this.selectedIndex=0}) : super(key: key);

  @override
  _OurNavState createState() => _OurNavState();
}

class _OurNavState extends State<OurNav> {
  // OurNav outnavstate = new OurNav();
  // int _selectedIndex = outnavstate.selectedIndex;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Bookmark(),
    Search(),
    Profile(),
  ];

  // static int get selectedIndex => ;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: kMainColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmarked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Adv Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        // onTap: (int index){ _selectedTab(pageKeys['index'], index)''}
      ),
    );
  }
}
