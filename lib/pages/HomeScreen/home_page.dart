import 'package:fitnessapp/pages/tabs/home_page_tabs/lats_tab.dart';
import 'package:fitnessapp/pages/tabs/home_page_tabs/legs_tab.dart';
import 'package:fitnessapp/pages/tabs/home_page_tabs/pecs_tab.dart';
import 'package:fitnessapp/pages/tabs/home_page_tabs/shoulders_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              "Workout List",
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
              PecsTab(),
              LatsTab(),
              LegsTab(),
              ShouldersTab(),
            ]),
          )
        ]),
      ),
    );
  }
}
