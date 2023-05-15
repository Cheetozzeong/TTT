import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/common_appbar.dart';
import 'package:material_dialogs/dialogs.dart';

import '../../const/serveraddress.dart';
import 'package:http/http.dart' as http;

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CameraScreen();
}

class _CameraScreen extends State<CameraScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');



  Future<void> setSharedPreferences(String qrCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await checkAccessToken(qrCode);
    sharedPreferences.setString('qrCode', qrCode!);
  }

  Future<http.Response> sendAccessToken(String qrCode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/watchfcmtoken/register');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': accessToken,
      },
      body: jsonEncode(<String, String>{
        'watchFcmToken': qrCode,
      }),
    );
    return response;
  }

  Future<void> checkAccessToken(String qrCode) async {
    final response = await sendAccessToken(qrCode);
    if (response.statusCode == 200) {
      print(qrCode+" 디바이스 토큰 보내버렸쥬");
    } else {
      print('Login failed with status: ${response.statusCode}');
    }
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '워치와 연결'),
        body: Column(
          children: [
            Expanded(flex: 4, child: _buildQrView(context)),
            SizedBox(
              height: deviceHeight * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: result != null ? Builder(builder: (context) {

                      setSharedPreferences(result!.code.toString()).then((value) => Navigator.of(context).popUntil((route) => route.isFirst));

                      return Container();
                    }) : Text('워치에 표시된 \nQR 코드를 찍어주세요.', style: TextStyle(fontSize: 25,), textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
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
}