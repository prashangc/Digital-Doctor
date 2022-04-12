import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:digitaldoctor/BottomNavigations/AllAppointments.dart';
import 'package:digitaldoctor/BottomNavigations/Favourites.dart';
import 'package:digitaldoctor/BottomNavigations/HomePage.dart';
import 'package:digitaldoctor/BottomNavigations/Profile.dart';
import 'package:digitaldoctor/BottomNavigations/Settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2;
  final List<Widget> screens = [
    const Profile(),
    const AllAppointments(),
    const HomePage(),
    const Favourite(),
    const Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.red,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.red,
        height: 55,
        items: const <Widget>[
          Icon(FontAwesomeIcons.user, color: Colors.white, size: 20.0),
          Icon(FontAwesomeIcons.calendarAlt, color: Colors.white, size: 20.0),
          Icon(Icons.home, color: Colors.white, size: 25.0),
          Icon(Icons.favorite, color: Colors.white, size: 25.0),
          Icon(Icons.settings, color: Colors.white, size: 20.0),
        ],
        index: _currentIndex,
        animationDuration: const Duration(
          milliseconds: 300,
        ),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print("kkkkkk: $_currentIndex");
          });
        },
      ),
    );
  }
}
