import 'dart:convert';

import 'package:divinity_expo/Screens/BottomNavigationBar/bottom_navigation_bar_screen.dart';
import 'package:divinity_expo/Widgets/boot_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/color.dart';
import '../../login_screen/login_screen.dart';

class SeeAllBooths extends StatefulWidget {
  const SeeAllBooths({Key? key}) : super(key: key);

  @override
  State<SeeAllBooths> createState() => _SeeAllBoothsState();
}

class _SeeAllBoothsState extends State<SeeAllBooths> {

  String? token;

  void retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      print('My fetch token is $token');

    });
  }

  Future<List<dynamic>> fetchSponsors() async {
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
      throw Exception('Failed to fetch sponsors');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveToken();
    fetchSponsors();
  }

  @override
  Widget build(BuildContext context) {
    var ScrenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/home_bg.png'),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/back2.png',
                      height: 25.h,
                      width: 40.w,
                    )),
                SizedBox(
                  width: 15.w,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'All Booths',
                    style: GoogleFonts.lora(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ),
                SizedBox(
                  width: 65.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
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
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
