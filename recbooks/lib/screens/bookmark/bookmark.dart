import 'package:flutter/material.dart';
import 'package:recbooks/constants/color_constant.dart';


class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recbooks - Find your next read'),
        backgroundColor: kMainColor,
      ),
      body: const Center(
        child: Text('Bookmark'),
      ),
    );
  }
}