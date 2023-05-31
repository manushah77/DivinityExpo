import 'package:divinity_expo/Screens/SplashScreens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {

  runApp( MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),

  );

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
        // designSize: Size(380, 800),
        designSize: Size(360, 760),
        minTextAdapt: true,

    // splitScreenMode: true,
    builder: (context, child) =>  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    ));
  }
}
