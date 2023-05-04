import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/common_appbar.dart';

late var strIdToken = "";
class TosScreen extends StatelessWidget {
  const TosScreen({Key? key}) : super(key: key);

  checkToken() async {
    SharedPreferences hsaredPreferences = await SharedPreferences.getInstance();
    strIdToken = hsaredPreferences.getString('idToken')!;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    checkToken();

    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(appBarType: AppBarType.normalAppBar, title: '이용 약관'),
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
                    '이용 약관',
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
                          strIdToken,
                          style: TextStyle(
                            fontFamily: "NotoSansKr",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      ElevatedButton(
                        child: Text("COPY"),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: strIdToken));
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
