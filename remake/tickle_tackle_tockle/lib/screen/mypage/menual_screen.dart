import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../component/common_appbar.dart';

class ManualScreen extends StatelessWidget {
  List<String> images = [
    'assets/images/guide/guide_1.png',
    'assets/images/guide/guide_2.png',
    'assets/images/guide/guide_3.png',
    'assets/images/guide/guide_4.png',
    'assets/images/guide/guide_5.png',
    'assets/images/guide/guide_6.png',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '사용 안내'),
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
                items: images.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: deviceWidth,
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        ),
      );
  }
}
