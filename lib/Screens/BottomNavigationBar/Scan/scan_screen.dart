import 'dart:convert';

import 'package:divinity_expo/Screens/BottomNavigationBar/Scan/bar_code_scan.dart';
import 'package:divinity_expo/Screens/BottomNavigationBar/Scan/see_all_both.dart';
import 'package:divinity_expo/Widgets/sponser_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constant/color.dart';
import '../../../Widgets/boot_container.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String? token;

 void retrieveToken() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
       setState(() {
         token = prefs.getString('token');
         print('My fetch token is $token');

       });
  }

  Future<List<dynamic>> fetchBooth() async {
    final response = await http
        .get(Uri.parse('https://divnity.jeuxtesting.com/api/booths'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final data = jsonBody['data'] as List<dynamic>;
      print(data.toString());
      return data;
    } else {
      throw Exception('Failed to fetch Booths');
    }
  }
  Future<List<dynamic>> fetchSponsors() async {
    final response = await http.get(
        Uri.parse('https://divnity.jeuxtesting.com/api/sponsers'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
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
    retrieveToken();

    fetchSponsors();
    fetchBooth();
  }



  @override
  Widget build(BuildContext context) {
    var ScrenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 260.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_bg.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 55.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 20),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Divinity',
                              style: GoogleFonts.petemoss(
                                fontSize: 56.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                          Text(
                            '🔥',
                            style: GoogleFonts.petemoss(
                              fontSize: 26,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BarCodeScaner(),
                                ),
                              );
                            },
                            child: Container(
                              height: 30.h,
                              width: 65.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColorTwo,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/scan.png',
                                    scale: 5,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      'Scan',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 9.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 31.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 28.0,
                      ),
                      child: Row(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'Our Wonderful Sponsors',
                              style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),

              FutureBuilder<List<dynamic>>(
                  future: fetchSponsors(),
                  builder: (context, AsyncSnapshot sp) {
                    if (!sp.hasData) {
                      return Center(child: CircularProgressIndicator(
                        color: primaryColor,
                      ));
                    }
                    final List data = sp.data;

                    return  Padding(
                      padding: EdgeInsets.only(top: 190.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var all in data)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0, bottom: 10, right: 20),
                                child: Container(
                                  height: 260.h,
                                  width: 320.w,
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
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          '${all['logoUrl']}',
                                          height: 181,
                                          width: 295.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                '${all['name']}',
                                                style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0, top: 5, bottom: 12),
                                        child: Row(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                '${all['description']}',
                                                style: GoogleFonts.lato(
                                                  fontSize: 10,
                                                  color: Color(0xff707070),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),

            ],
          ),
          // Center(
          //     child: Image.asset(
          //   'assets/images/sid.png',
          //   height: 5.h,
          //   width: 50.w,
          // )),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Booths',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    textScaleFactor: 1,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeeAllBooths(),
                      ),
                    );
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'See all',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w300,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          FutureBuilder<List<dynamic>>(
              future: fetchBooth(),
              builder: (context, AsyncSnapshot sp) {
                if (!sp.hasData) {
                  return Center(child: CircularProgressIndicator(
                    color: primaryColor,

                  ));
                }
                final List data = sp.data;

                return Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, int index) {
                        return BootContainer(
                          img: '${data[index]['imageUrl']}',
                          bootNum: '${data[index]['boothNo']}',
                          bootName: '${data[index]['companyName']}',
                          bootDesc: '${data[index]['description']}', bootStatus: '${data[index]['status']}', bootLocation: '${data[index]['location']}',
                        );
                      }),
                );
              }),
          SizedBox(
            height: 10.h,
          ),
          // SponserContainer(img: 'assets/images/mic.png'),

        ],
      ),
    );
  }

  // Future<String?> getTokenFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }
}
