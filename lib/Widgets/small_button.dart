import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constant/color.dart';

class SmallCustomButton extends StatelessWidget {
  final String name;
  final Function ontap;
  const SmallCustomButton({Key? key, required this.name, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      onPressed: () {
        ontap();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: primaryColorTwo,
      height: 55.h,
      minWidth: 190.w,
      child: Text(
        '${name}',
        style: GoogleFonts.montserrat(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
