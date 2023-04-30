import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(appBarType: AppBarType.normalAppBar, title: '설정'),
        body: Padding(
          padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, deviceHeight * 0.02, deviceWidth * 0.05, 0),
          child: Container(
            height: deviceHeight * 0.5,
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
            child: const Text('test'),
          ),
        ),
      ),
    );
  }
}