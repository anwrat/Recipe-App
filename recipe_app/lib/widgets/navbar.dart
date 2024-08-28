import 'package:flutter/material.dart';
import 'package:recipe_app/utils/colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon:_buildiconwithbg(
            icon: IconData(0xe318, fontFamily: 'MaterialIcons'),
            backgroundColor: MyColors.primarycolor,
            iconcolor: MyColors.mainwhite,
          ),
          activeIcon:_buildiconwithbg(
            icon: IconData(0xe318, fontFamily: 'MaterialIcons'),
            backgroundColor:MyColors.navactiveicon,
            iconcolor: MyColors.mainblack
            ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon:_buildiconwithbg(
            icon: IconData(0xe567, fontFamily: 'MaterialIcons'),
            backgroundColor: MyColors.primarycolor,
            iconcolor: MyColors.mainwhite,
          ),
          activeIcon:_buildiconwithbg(
            icon: IconData(0xe567, fontFamily: 'MaterialIcons'),
            backgroundColor:MyColors.navactiveicon,
            iconcolor: MyColors.mainblack,
            ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon:_buildiconwithbg(
            icon: IconData(0xe491, fontFamily: 'MaterialIcons'),
            backgroundColor: MyColors.primarycolor,
            iconcolor: MyColors.mainwhite,
          ),
          activeIcon:_buildiconwithbg(
            icon: IconData(0xe491, fontFamily: 'MaterialIcons'),
            backgroundColor:MyColors.navactiveicon,
            iconcolor: MyColors.mainblack,
            ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon:_buildiconwithbg(
            icon: IconData(0xe57f, fontFamily: 'MaterialIcons'),
            backgroundColor: MyColors.primarycolor,
            iconcolor: MyColors.mainwhite,
          ),
          activeIcon:_buildiconwithbg(
            icon: IconData(0xe57f, fontFamily: 'MaterialIcons'),
            backgroundColor:MyColors.navactiveicon,
            iconcolor: MyColors.mainblack,
            ),
          label: '',
        ),
      ],
      // selectedItemColor: MyColors.mainblack, // Active icon color
      // unselectedItemColor: MyColors.mainwhite, // Inactive icon color
      // Hide labels for inactive and active items
      showSelectedLabels: false,
      showUnselectedLabels: false, 
      backgroundColor: MyColors.primarycolor,
      type:BottomNavigationBarType.fixed,
      elevation: 8.0,
    );
  }
   Widget _buildiconwithbg({required IconData icon, required Color backgroundColor,required Color iconcolor}) {
    return Container(
      width: 40, // Width of the square
      height: 40, // Height of the square
      decoration: BoxDecoration(
        color: backgroundColor, // Background color
        shape: BoxShape.rectangle, // Square shape
        borderRadius: BorderRadius.circular(4), // Optional: slightly rounded corners
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: iconcolor,
        size: 20,
      ),
    );
  }
}
