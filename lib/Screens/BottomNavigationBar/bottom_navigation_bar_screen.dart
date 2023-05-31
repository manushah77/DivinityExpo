import 'package:divinity_expo/Constant/color.dart';
import 'package:divinity_expo/Screens/BottomNavigationBar/ProfileScreen/profile_screen.dart';
import 'package:divinity_expo/Screens/BottomNavigationBar/Scan/scan_screen.dart';
import 'package:divinity_expo/Screens/BottomNavigationBar/SponsorsScreen/sponser_screen.dart';
import 'package:divinity_expo/Screens/ForgetPasswordScreem/forget_password_screen.dart';
import 'package:divinity_expo/Screens/SignupScreen/signup_screen.dart';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 1;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // _pageController = PageController();
    // _index = 1; // Set initial index to 1
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> _children = [
    SponserScreen(),
    ScanScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _index,
        height: 50.0,
        items: <Widget>[
          Image.asset(
            'assets/images/heart.png',
            scale: 2.5,
            color: _index == 0 ? Colors.white : Colors.black,
          ),
          Image.asset(
            'assets/images/home.png',
            scale: 3,
            color: _index == 1 ? Colors.white : Colors.black,
          ),
          Image.asset(
            'assets/images/man.png',
            scale: 2.5,
            color: _index == 2 ? Colors.white : Colors.black,
          ),
        ],
        color: Colors.grey.withOpacity(0.2),
        buttonBackgroundColor: ascentColor,
        backgroundColor: Colors.white38,
        animationCurve: Curves.easeIn,
        animationDuration: Duration(milliseconds: 700),
        onTap: (index) {
          print(index);
          setState(() {
            _index = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 700), curve: Curves.ease);
          });
        },
      ),
      body: SizedBox.expand(
        child: Container(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(
                () => _index = index,
              );

              // _pageController.jumpToPage(index);
            },
            children: _children,
          ),
        ),
      ),
    );
  }
}
