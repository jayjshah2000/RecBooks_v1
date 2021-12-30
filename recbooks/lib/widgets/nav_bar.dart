import 'package:flutter/material.dart';
import 'package:recbooks/constants/color_constant.dart';
import 'package:recbooks/screens/bookmark/bookmark.dart';
import 'package:recbooks/screens/home/home.dart';
import 'package:recbooks/screens/profile/profile.dart';

class OurNav extends StatefulWidget {
  const OurNav({ Key? key }) : super(key: key);

  @override
  _OurNavState createState() => _OurNavState();
}

class _OurNavState extends State<OurNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Bookmark(),
    Profile(),
  ];

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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
