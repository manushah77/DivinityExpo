import 'dart:convert';

import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/color.dart';
import '../bottom_navigation_bar_screen.dart';

class BarCodeScaner extends StatefulWidget {
  const BarCodeScaner({Key? key}) : super(key: key);

  @override
  State<BarCodeScaner> createState() => _BarCodeScanerState();
}

class _BarCodeScanerState extends State<BarCodeScaner> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AiBarcodeScanner(
        validator: (String value) {
          return false;
        },
        onScan: (String value) {
          // CodeScan(value);
          print("Resulting Respone code " + value);
          // CodeScan('');
        },
        onDetect: (_) {
          CodeScan(_.toString());
        },
        // onScannerStarted: (_){},
      ),
    );
  }

  String? msg;
  Future CodeScan(String responeFromScan) async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://divnity.jeuxtesting.com/api/getBooth/' + responeFromScan),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        msg = data["message"];
        print("Masuuaisduai : $msg");
        // print(data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          content: Text(
            "Successfully Scan",
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
            "Error",
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
}
