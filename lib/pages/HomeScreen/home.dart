import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitnessapp/pages/AccountScreen/account_page.dart';
import 'package:fitnessapp/pages/FavoriteScreen/favorite_page.dart';
import 'package:fitnessapp/pages/HomeScreen/home_page.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    FavoritePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60.0,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        color: Colors.blueGrey.shade900,
        letIndexChange: (index) => true,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, color: Colors.lightGreenAccent),
          Icon(Icons.favorite, color: Colors.lightGreenAccent),
          Icon(Icons.person, color: Colors.lightGreenAccent),
        ],
      ),
      body: _pages[_currentPageIndex],
    );
  }
}
