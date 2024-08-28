import 'package:flutter/material.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/utils/colors.dart';
import 'package:recipe_app/widgets/logo.dart';
import 'package:recipe_app/widgets/navbar.dart';

class HomePage extends StatefulWidget{
  const HomePage();
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,//height of appbar
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoSection(image: 'assets/images/mainlogo.png'),
          ],
        ), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getSelectedScreen(_selectedIndex),
          ],
        ),
      ),
      //To place the navbar at bottom of screen
      bottomNavigationBar: NavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
        floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primarycolor,
        onPressed:(){
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) =>
                      const MyApp(),
                    )
                );
        },
        child: const Icon(color: Color(0xffFFFFFF),Icons.add,),
      ),
    );
  }
  Widget _getSelectedScreen(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const Text('Search Screen');
      case 2:
        return const Text('Account Screen');
      case 3:
        return const Text('Settings');
      default:
        return const Text('Home Screen');
    }
  }
}