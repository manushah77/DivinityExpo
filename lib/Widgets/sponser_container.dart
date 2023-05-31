import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Model/sponser_model.dart';
import 'package:http/http.dart' as http;

class SponserContainer extends StatefulWidget {
  final String img;
  final String name;
  final String descrip;
   String? location;

  SponserContainer({Key? key, required this.img, required this.name, required this.descrip,  this.location}) : super(key: key);

  @override
  State<SponserContainer> createState() => _SponserContainerState();
}

class _SponserContainerState extends State<SponserContainer> {
  // AllSponsers? allSponsers;

  Future<List<dynamic>> fetchSponsors() async {
    final response = await http.get(
        Uri.parse('https://divnity.jeuxtesting.com/api/sponsers'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 3|0xTj0rOrhsoLZoxwz7W4ikQMC3qEjis9MJIbwNEv',
        });

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final data = jsonBody['data'] as List<dynamic>;
      print(data.toString());
      return data;
    } else {
      throw Exception('Failed to fetch sponsors');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSponsors();
  }

  @override
  Widget build(BuildContext context) {


  return  Padding(
      padding: EdgeInsets.only(left: 18.0, right: 18,bottom: 20),
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
                      image:  widget.img == '' ? NetworkImage('https://cdn-icons-png.flaticon.com/512/1179/1179237.png'): NetworkImage(
                        '${widget.img}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.name}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Location : ${widget.location}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${widget.descrip}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                        textScaleFactor: 1,
                      ),
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 128.0, bottom: 10),
                          child: Container(
                            height: 21.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(30.r),
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
                                  'Visited',
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
