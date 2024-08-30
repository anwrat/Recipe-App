import 'package:flutter/material.dart';
import 'package:recipe_app/home.dart';
import 'package:recipe_app/search.dart';
import 'package:recipe_app/utils/colors.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: MyColors.primarycolor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorShape: RoundedRectangleBorder(),
        indicatorColor: MyColors.navactiveicon,
        selectedIndex: currentPageIndex,
        height: 70,
        destinations: 
        const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe318, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 50,),
            icon: Icon(IconData(0xe318, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 50,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe567, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 50,),
            icon: Icon(IconData(0xe567, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 50,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe491, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 50,),
            icon: Icon(IconData(0xe491, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 50,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe57f, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 50,),
            icon: Icon(IconData(0xe57f, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 50,),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        //Home Page
        const HomePage(),

        /// Search page
        const SearchPage(),

        /// Account page
        const SearchPage(),

        /// Settings Page
        const SearchPage(),
      ][currentPageIndex],
    );
  }
}
