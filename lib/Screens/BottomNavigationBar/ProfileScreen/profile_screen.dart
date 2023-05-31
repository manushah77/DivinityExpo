import 'dart:convert';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:divinity_expo/Screens/SplashScreens/welcome_screen.dart';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:divinity_expo/Widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/color.dart';
import '../../../Widgets/custom_text_field.dart';
import '../../../Widgets/second_custom_text_field.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? token;
  String? id;
  String? nam;
  String? email;
  String? phn;

  void retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      id = prefs.getString('id');
      nam = prefs.getString('fullName');
      email = prefs.getString('email');
      phn = prefs.getString('phone');

      print('My fetch id is $id');
      print('My fetch token is $token');
      print('My fetch Name is $nam');
      print('My fetch Email is $email');
      print('My fetch Phone is $phn');
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 460.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/home_bg.png'),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Profile',
                          style: GoogleFonts.lora(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),

                  //name
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Full Name',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 330.w,
                    height: 60.h,
                    child: SecondCustomTextField(
                      validate: true,
                      hintText: nam,
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  //Email Adress
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Email Address',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 330.w,
                    height: 60.h,
                    child: SecondCustomTextField(
                      validate: true,
                      hintText: email,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //phone

                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Phone Number',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: 330.w,
                    height: 60.h,
                    child: SecondCustomTextField(
                      validate: true,
                      hintText: phn,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  Text(
                    'Visted Booths',
                    style: GoogleFonts.montserrat(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Image.asset(
              'assets/images/prog.PNG',
              scale: 1.3,
            ),
            SizedBox(
              height: 5.h,
            ),
            SmallCustomButton(
                name: 'LogOut',
                ontap: () async{
                  // Store the token in SharedPreferences
                  SharedPreferences prefs = await SharedPreferences
                      .getInstance();
                  prefs.setString('token', '');
                  prefs.setString('id', '');
                  prefs.setString('email', '');
                  prefs.setString('fullName', '');
                  prefs.setString('phone', '');


                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    content: Text(
                      "Successfully Logout",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    duration: Duration(seconds: 2),
                  ));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                },

            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
