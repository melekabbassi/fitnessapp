import 'package:fitnessapp/pages/tabs/fav_page_tabs/fav_lats_tab.dart';
import 'package:fitnessapp/pages/tabs/fav_page_tabs/fav_legs_tab.dart';
import 'package:fitnessapp/pages/tabs/fav_page_tabs/fav_pecs_tab.dart';
import 'package:fitnessapp/pages/tabs/fav_page_tabs/fav_shoulders_tab.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Center(
            child: Text(
              "Favorites",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreenAccent),
            ),
          ),
        ),
        body: const Column(children: [
          TabBar(
            labelColor: Colors.lightGreenAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.lightGreenAccent,
            tabs: [
              Tab(text: "Pecs"),
              Tab(text: "Lats"),
              Tab(text: "Legs"),
              Tab(text: "Shoulders"),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              FavPecsTab(),
              FavLatsTab(),
              FavLegsTab(),
              FavShouldersTab(),
            ]),
          )
        ]),
      ),
    );
  }
}
