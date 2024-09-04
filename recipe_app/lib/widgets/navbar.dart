import 'package:flutter/material.dart';
import 'package:recipe_app/home.dart';
import 'package:recipe_app/profilepage.dart';
import 'package:recipe_app/search.dart';
import 'package:recipe_app/settings.dart';
import 'package:recipe_app/utils/colors.dart';


class NavigationBarApp extends StatefulWidget {
  final String username;
  const NavigationBarApp({required this.username,super.key});

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
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
        indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        indicatorColor: MyColors.navactiveicon,
        selectedIndex: currentPageIndex,
        height: 70,
        destinations: 
        const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe318, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 40,),
            icon: Icon(IconData(0xe318, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 40,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe567, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 40,),
            icon: Icon(IconData(0xe567, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 40,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe491, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 40,),
            icon: Icon(IconData(0xe491, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 40,),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(IconData(0xe57f, fontFamily: 'MaterialIcons'),color: MyColors.mainblack,size: 40,),
            icon: Icon(IconData(0xe57f, fontFamily: 'MaterialIcons'),color: MyColors.mainwhite,size: 40,),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        //Home Page
        HomePage(username: widget.username,),

        /// Search page
        SearchPage(username: widget.username,),

        /// Account page
        ProfilePage(username: widget.username,),

        /// Settings Page
        Settings(username: widget.username,),
      ][currentPageIndex],
    );
  }
}
