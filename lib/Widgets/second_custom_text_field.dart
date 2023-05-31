import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondCustomTextField extends StatefulWidget {
  String? hintText;
  final prefixIcon;
  final IconButton? suffixIcon;
  final bool? obsecureText;
  TextEditingController? controller;
  String? errorTxt;
  bool? validate;
  final maxlines;
  final minlines;
  final onchange;
  final keyboradType;

  SecondCustomTextField(
      {Key? key,
        this.hintText,
        this.prefixIcon,
        this.suffixIcon,
        this.obsecureText,
        this.controller,
        this.maxlines,
        this.minlines,
        this.validate,
        this.onchange,
        this.keyboradType})
      : super(key: key);

  @override
  State<SecondCustomTextField> createState() => _SecondCustomTextFieldState();
}

class _SecondCustomTextFieldState extends State<SecondCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      cursorColor: Colors.white,
      style: GoogleFonts.montserrat(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      obscureText: widget.obsecureText ?? false,
      keyboardType: TextInputType.multiline,
      controller: widget.controller,
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        if (widget.validate != null) {
          if (value == null || value.isEmpty) {
            return widget.errorTxt;
          }
          return null;
        }
      },
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        suffixIconColor: Colors.white,
        contentPadding: EdgeInsets.only(top: 2, left: 15, right: 13),
        border: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.openSans(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        // filled: true,
        // fillColor: Colors.grey.withOpacity(0.2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Colors.white38, width: 1),
        ),
      ),
    );
  }
}
