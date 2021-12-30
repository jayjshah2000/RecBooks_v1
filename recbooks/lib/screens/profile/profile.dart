import 'package:flutter/material.dart';
import 'package:recbooks/constants/color_constant.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recbooks - Find your next read'),
        backgroundColor: kMainColor,
      ),
      body: const Center(
        child: Text('Profile'),
      ),
    );
  }
}