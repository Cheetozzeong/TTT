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
        body: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: deviceWidth * 1.6  / deviceHeight * 0.9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  autoPlay: false,
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
