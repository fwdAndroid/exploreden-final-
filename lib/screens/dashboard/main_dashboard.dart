import 'package:exploreden/screens/dashboard/pages/favourite_page.dart';
import 'package:exploreden/screens/dashboard/pages/home_page.dart';
import 'package:exploreden/screens/dashboard/pages/message_page.dart';
import 'package:exploreden/screens/dashboard/pages/profile_page.dart';
import 'package:exploreden/utils/colors.dart';
import 'package:flutter/material.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(), // Replace with your screen widgets
    FavouritePage(),
    MessagePage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Image.asset(
              _currentIndex == 0 ? 'assets/homecolor.png' : 'assets/home.png',
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: "Favourite",
            icon: Image.asset(
              _currentIndex == 1 ? 'assets/heartcolor.png' : 'assets/heart.png',
              height: 25,
            ),
          ),
          BottomNavigationBarItem(
            label: "Location",
            icon: Icon(
              Icons.location_pin,
              size: 25,
              color: _currentIndex == 2 ? mainColor : colorBlack,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Image.asset(
              _currentIndex == 3 ? 'assets/bar.png' : 'assets/homepage 7.png',
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
