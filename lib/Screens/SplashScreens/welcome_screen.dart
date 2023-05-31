import 'dart:async';
import 'package:divinity_expo/Constant/color.dart';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // super.initState();
    // FirebaseAuth.instance.userChanges().listen(
    //       (user) {
    //     Timer(
    //       Duration(seconds: 3),
    //           () => Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(
    //           builder: (BuildContext context) =>
    //           user != null ? BottomNavigation() : LoginPage(),
    //         ),
    //       ),
    //     );
    //   },
    // );
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) =>
    //     LoginPage()
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wel.gif'),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 45.h,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Featured at Divinity\n Expo Events',
                style: GoogleFonts.lora(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                textScaleFactor:1,

              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'We want answers about our relationships, our career,\n our happiness and our health. It\'s easy to consumed\n by the "what if\'s" that come into our minds, making\n us believe that things could be worse off than they\n really are, so it\'s natural to want to seek answers to\n these very important questions.',
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor:1,


                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(460),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen(),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: primaryColorTwo,
              height: ScreenUtil().setHeight(60),
              minWidth: ScreenUtil().setWidth(270),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Get Started',
                  style: GoogleFonts.montserrat(
                    fontSize: ScreenUtil().setSp(12),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
