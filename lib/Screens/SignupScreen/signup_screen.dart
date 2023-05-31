import 'dart:convert';

import 'package:auth_buttons/auth_buttons.dart';
import 'package:divinity_expo/Model/user_model.dart';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../Constant/color.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/small_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool ispasswordvisible = true;
  bool ispasswordvisibleTwo = true;
  bool isUploaded = false;

  @override
  Widget build(BuildContext context) {
    var screnSize = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0.0),
      //   child: AppBar(
      //     elevation: 0,
      //     backgroundColor: Colors.white,
      //     automaticallyImplyLeading: false, // hides leading widget
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarIconBrightness: Brightness.dark,
      //     ),
      //   ),
      // ),
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
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(80),
                  ),

                  Container(
                    width: 327.w,
                    height: 640.h,
                    decoration: BoxDecoration(
                      color: Color(0xffd9e4ed),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
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
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Image.asset(
                                    'assets/images/back1.png',
                                    height: 22.h,
                                    width: 34.w,
                                  ),
                                )),
                            SizedBox(
                              width: 50.w,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'SignUp',
                                style: GoogleFonts.lora(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textScaleFactor: 1,
                              ),
                            ),
                            SizedBox(
                              width: 123.w,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25.h,
                        ),

                        //email

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Full Name',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
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
                          child: CustomTextField(
                            validate: true,
                            controller: nameC,
                            hintText: 'Barbara Mahindra',
                          ),
                        ),

                        //email

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Email address',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
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

                        //phone number

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Phone Number(Optional)',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
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
                          height: 70.h,
                          child: IntlPhoneField(
                            showCountryFlag: false,
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                            cursorColor: Colors.black,
                            controller: phoneC,
                            validator: (_) {
                              if (_ == null || _ == '') {
                                return 'Enter number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                left: 5,
                                top: 5,
                                bottom: 2,
                                right: 5,
                              ),
                              hintText: '302224422',
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                              labelStyle: GoogleFonts.openSans(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.black54, width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                            initialCountryCode: 'PK',
                            onChanged: (value) {},
                            onCountryChanged: (country) {
                              // this.phoneNo = country.toString();
                            },
                          ),
                        ),
                        //password

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Choose a Password',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
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
                          child: CustomTextField(
                            hintText: '*********',
                            controller: passwordC,
                            validate: true,
                            obsecureText: ispasswordvisible,
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
                          ),
                        ),

                        //confirm password

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Confirm Password',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
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
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            controller: confirmPasswordC,

                            // ignore: body_might_complete_normally_nullable
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != passwordC.text) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  content: Text(
                                    "Psasword Not Match",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 19),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));

                                // return 'Passwords do not match';
                              }
                              return null;
                            },
                            obscureText: ispasswordvisibleTwo,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispasswordvisibleTwo =
                                        !ispasswordvisibleTwo;
                                  });
                                },
                                icon: Icon(
                                  size: 16,
                                  ispasswordvisibleTwo
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              suffixIconColor: Colors.grey,
                              contentPadding: EdgeInsets.only(
                                  top: 10, left: 15, right: 13, bottom: 10),
                              border: InputBorder.none,
                              hintText: '*********',
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
                          height: 20.h,
                        ),
                        SmallCustomButton(
                            name: 'Sign Up',
                            ontap: () {

                              if(formKey.currentState!.validate())
                                {
                                  signUp(
                                    emailC.text.toString(),
                                    passwordC.text.toString(),
                                    nameC.text.toString(),
                                    phoneC.text.toString(),
                                    confirmPasswordC.text.toString(),
                                  ).then((value) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  });
                                }

                            }),
                      ],
                    ),
                  ),

                  //

                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Already have an account?',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
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
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            ' Login',
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
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp(String email, pasword, name, phone, confimPass) async {
    try {
      http.Response response = await http
          .post(Uri.parse('https://divnity.jeuxtesting.com/api/signup'), body: {
        'email': email,
        'password': pasword,
        'fullName': name,
        'phone': phone,
        'password_confirmation': confimPass,
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print('Sucessfully Done');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Sucessfully Created",
            style: TextStyle(color: Colors.white, fontSize: 19),
          ),
          duration: Duration(seconds: 2),
        ));
      } else {
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Email Already Taken",
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
      ));    }
  }
}
