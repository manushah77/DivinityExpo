import 'dart:convert';
import 'dart:io';
import 'package:divinity_expo/Screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/color.dart';
import '../bottom_navigation_bar_screen.dart';
import 'package:http/http.dart' as http;

class QrCodePage extends StatefulWidget {
  const QrCodePage({Key? key}) : super(key: key);

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Barcode? result;
  QRViewController? controller;
  bool isTorchOn = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? token;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  getToken() async {
    getTokenFromSharedPreferences().then((value) {
      setState(() {
        token = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Row(
          children: [
            const Text(
              'Qr Scanner',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(
                isTorchOn ? Icons.flash_off : Icons.flash_on,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isTorchOn = !isTorchOn;
                });
                controller?.toggleFlash();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.black, borderRadius: 10, borderLength: 30, borderWidth: 10, cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController scanCoontroller) {
    controller = scanCoontroller;
    scanCoontroller.scannedDataStream.listen((scanData) {
      scanCoontroller.pauseCamera();
      result = scanData;
      String? id = result?.code.toString();
      matchIds(id ?? '');
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  showSnackBarAndNavigate(bool isNavigate, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white, fontSize: 19),
      ),
      duration: const Duration(seconds: 2),
    ));
    isNavigate
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavBar(),
            ),
          )
        : null;
  }

  String? msg;
  Future apiCall(String responeFromScan) async {
    try {
      http.Response response = await http.get(Uri.parse(responeFromScan), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          msg = data['message'];
        });
        showSnackBarAndNavigate(true, 'Successfully Scan');
      } else {
        showSnackBarAndNavigate(false, 'Scan Failed');
        controller?.resumeCamera();
      }
    } catch (e) {
      showSnackBarAndNavigate(false, e.toString());
      controller?.resumeCamera();
    }
  }

  matchIds(String id) {
    apiCall(id);
  }
}
