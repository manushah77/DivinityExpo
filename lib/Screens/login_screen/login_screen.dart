import 'dart:convert';

import 'package:divinity_expo/Screens/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:divinity_expo/Screens/ForgetPasswordScreem/forget_password_screen.dart';
import 'package:divinity_expo/Widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/color.dart';
import '../../Widgets/custom_text_field.dart';
import '../SignupScreen/signup_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool ispasswordvisible = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screnSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/grid.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              height: 760.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 96.h,
                      width: 133.w,
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      'assets/images/div2.png',
                      height: 61.h,
                      width: 124.w,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  //login Container

                  Container(
                    width: 320.w,
                    height: 400.h,
                    decoration: BoxDecoration(
                      color: Color(0xffd9e4ed),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Login',
                            style: GoogleFonts.lora(
                              fontSize: 33,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(15),
                        ),

                        //email

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Email address',
                                  style: GoogleFonts.montserrat(
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
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
                          width: 300.w,
                          height: 60.h,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: GoogleFonts.openSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            controller: emailC,
                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              var email = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                              if (value == null || value == '') {
                                return 'Enter Your Email';
                              } else if (email.hasMatch(value)) {
                                return null;
                              } else
                                return "Wrong Email Adress";
                            },

                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 15, right: 13, bottom: 10),
                              border: InputBorder.none,
                              hintText: 'barab@gmail.com',
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                              // filled: true,
                              // fillColor: Colors.grey.withOpacity(0.2),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.black54, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                          ),
                        ),

                        //password

                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Choose a Password',
                                  style: GoogleFonts.montserrat(
                                    fontSize: ScreenUtil().setSp(15),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  textScaleFactor: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        SizedBox(
                          width: 300.w,
                          height: 60.h,
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            controller: passwordC,

                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter your password';
                              }
                              return null;
                            },
                            obscureText: ispasswordvisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispasswordvisible = !ispasswordvisible;
                                  });
                                },
                                icon: Icon(
                                  size: 16,
                                  ispasswordvisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              suffixIconColor: Colors.grey,
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 15, right: 13, bottom: 10),
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.black54, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setSp(8),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 18.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen(),
                                    ),
                                  );
                                },
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'Forgot Password ?',
                                    style: GoogleFonts.montserrat(
                                      fontSize: ScreenUtil().setSp(13),
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        SmallCustomButton(
                            name: 'Login',
                            ontap: () {
                              if (formKey.currentState!.validate()) {
                                Login(emailC.text.toString(),
                                        passwordC.text.toString())
                                    .then((value) {
                                  if (value) {
                                    getTokenFromSharedPreferences();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavBar(),
                                      ),
                                    );
                                  }
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                          textScaleFactor: 1.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ' Sign Up',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ascentColor,
                            ),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future Login(String email, pasword) async {
    try {
      http.Response response = await http
          .post(Uri.parse('https://divnity.jeuxtesting.com/api/login'), body: {
        'email': email,
        'password': pasword,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        String token = data['data']['token'];
        String id = data['user']['id'].toString();
        String email = data['user']['email'];
        String nam = data['user']['fullName'];
        String phn = data['user']['phone'].toString();

        // Store the token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('id', id);
        prefs.setString('email', email);
        prefs.setString('fullName', nam);
        prefs.setString('phone', phn);
        print(
          'The nam and the token and id is : $nam , $token, $id ,$email , $phn',
        );

        // print(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Successfully Login",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavBar(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Enter Correct Email And Password",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        content: Text(
          "${e.toString()}",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
