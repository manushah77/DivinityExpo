import 'dart:async';
import 'package:divinity_expo/Screens/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:divinity_expo/Screens/SplashScreens/welcome_screen.dart';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  String? token;

  void retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      print('My fetch token is $token');

    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveToken();
    Timer(
      Duration(seconds: 5),
      () {
        if(token ==null || token =='') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => WelcomeScreen(),
            ),
          );
        }
        else {

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => BottomNavBar(),
            ),
          );
        }
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 96.h,
                  width: 133.w,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Image.asset(
                  'assets/images/div1.png',
                  height: 63.h,
                  width: 123.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
