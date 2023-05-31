import 'dart:convert';

import 'package:divinity_expo/Model/sponser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/color.dart';
import '../../../Widgets/sponser_container.dart';
import 'package:http/http.dart' as http;


class SponserScreen extends StatefulWidget {
  const SponserScreen({Key? key}) : super(key: key);

  @override
  State<SponserScreen> createState() => _SponserScreenState();
}

class _SponserScreenState extends State<SponserScreen> {

  String? token;

  void retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      print('My fetch token is $token');

    });
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
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'All Sponsers',
                  style: GoogleFonts.lora(
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textScaleFactor: 1.0,

                ),
              ),
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
                        return SponserContainer(
                          img:  '${data[index]['logoUrl']}',
                          name: '${data[index]['name']}',
                          descrip: '${data[index]['description']}',
                          location: '${data[index]['location']}',

                        );
                      }),
                );
              }),
        ],
      ),
    );
  }





}
