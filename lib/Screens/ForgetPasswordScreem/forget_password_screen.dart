import 'dart:convert';

import 'package:divinity_expo/Constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Widgets/small_button.dart';
import '../login_screen/login_screen.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screnSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ascentColorTwo,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Image.asset(
                          'assets/images/back2.png',
                          height: 22.h,
                          width: 34.w,
                        ),
                      )),
                  SizedBox(
                    width: 35.w,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.lora(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                  SizedBox(
                    width: 82.w,
                  ),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              Container(
                width: 320.w,
                height: 615.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Image.asset(
                      'assets/images/forget.png',
                      height: 270.h,
                      width: 290.w,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Forgot your Password?',
                        style: GoogleFonts.lato(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Please enter the email address associated\n with your account. We\'ll mail you a link to\n reset your password.',
                        style: GoogleFonts.lato(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),

                    //email

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Enter Email Address',
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              textScaleFactor: 1,
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
                        style: GoogleFonts.montserrat(
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
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 12,
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
                    SizedBox(
                      height: 10.h,
                    ),

                    SmallCustomButton(
                        name: 'Send',
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            Forget(emailC.text.toString());
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bottomsheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35.r),
            topRight: Radius.circular(35.r),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 460.h,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Instruction Sent!',
                    style: GoogleFonts.lora(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  height: 8.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    color: ascentColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Lottie.asset(
                  'assets/send.json',
                  height: 200.h,
                  width: 230.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'The instruction has been sent to you over\n email, kindly follow the instruction to reset\n the password of your account.',
                    style: GoogleFonts.montserrat(
                      color: Color(0xff707070).withOpacity(0.8),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                SmallCustomButton(
                    name: 'Okay',
                    ontap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          );
        });
  }

  Future Forget(String email) async {
    try {
      http.Response response = await http
          .post(Uri.parse('https://divnity.jeuxtesting.com/api/forgot'), body: {
        'email': email,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Check Your Email Spam Folder",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
        print(response.statusCode);
        bottomsheet(context);
      } else {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Erorrs",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
        print(response.statusCode);
        print(data.toString());
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
}
