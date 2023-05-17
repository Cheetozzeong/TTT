import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/common_appbar.dart';

late var strToken = "";

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  checkToken() async {
    SharedPreferences hsaredPreferences = await SharedPreferences.getInstance();
    strToken = hsaredPreferences.getString('token')!;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    checkToken();

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '개인 정보 처리 방침'),
        body: Padding(
          padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, deviceHeight * 0.02, deviceWidth * 0.05, 0),
          child: Container(
            height: deviceHeight * 0.4,
            width: deviceWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Text(
                    '개인 정보 처리 방침',
                    style: TextStyle(
                      fontFamily: "NotoSansKr",
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  Column(
                    children: [
                      Container(
                        width: deviceWidth * 0.8,
                        child: Text(
                          strToken,
                          style: TextStyle(
                            fontFamily: "NotoSansKr",
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      ElevatedButton(
                        child: Text("COPY"),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: strToken));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}