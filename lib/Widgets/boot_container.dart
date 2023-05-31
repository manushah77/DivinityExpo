import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BootContainer extends StatefulWidget {
  final String img;
  final String bootNum;
  final String bootName;
  final String bootDesc;
  final String bootStatus;
  final String bootLocation;

  BootContainer(
      {Key? key,
      required this.img,
      required this.bootNum,
      required this.bootStatus,
      required this.bootName,
      required this.bootDesc, required this.bootLocation})
      : super(key: key);

  @override
  State<BootContainer> createState() => _BootContainerState();
}

class _BootContainerState extends State<BootContainer> {
  @override
  Widget build(BuildContext context) {
    var ScrenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18,bottom: 20),
      child: AspectRatio(
        aspectRatio: 1.6 / .6,
        child: Container(
          height: 128,
          width: 380,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Color(0xffF2F3F4),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 111,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(widget.img),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.bootNum}',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.bootName}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Location : ${widget.bootLocation}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.bootDesc}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 128.0, bottom: 10),
                          child: Container(
                            height: 21.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.bootStatus  == 0 ? 'NotVisit' : 'Visited',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 9.sp,
                                    color: Colors.black,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 18.w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
