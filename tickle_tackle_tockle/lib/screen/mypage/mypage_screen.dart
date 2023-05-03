import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.myPageAppBar, title: '마이 페이지',),
      body: Padding(
        padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, deviceHeight * 0.02, deviceWidth * 0.05, 0),
        child: Column(
          children: [
            Container(
              height: deviceHeight * 0.15,
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
              child: Padding(
                padding: EdgeInsets.all(deviceHeight * 0.02),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: deviceWidth * 0.085,
                      backgroundImage: CachedNetworkImageProvider(FirebaseAuth.instance.currentUser!.photoURL.toString()),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.05,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: deviceWidth * 0.5,
                          child: Text(
                            FirebaseAuth.instance.currentUser!.displayName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: deviceWidth * 0.06
                            ),
                          ),
                        ),
                        Container(
                          width: deviceWidth * 0.5,
                          child: Text(
                            FirebaseAuth.instance.currentUser!.email.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Container(
              height: deviceHeight * 0.15,
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
              child: Padding(
                padding: EdgeInsets.all(deviceHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '기본 컬러 설정',
                      style: TextStyle(
                        fontSize: deviceWidth * 0.055,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            themeController.selectedPrimaryColor = TTTPrimary1;
                            themeController.refreshTheme();
                          },
                          child: GetBuilder<ThemeController>(
                            builder: (_) {
                              return Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: TTTPrimary1,
                                    radius: deviceWidth * 0.05,
                                  ),
                                  themeController.selectedPrimaryColor == TTTPrimary1 ?
                                  Icon(
                                    Icons.check, size: deviceWidth * 0.1,
                                    color: TTTBlack,
                                  ) :
                                  Container(),
                                ],
                              );
                            }
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            themeController.selectedPrimaryColor = TTTPrimary2;
                            themeController.refreshTheme();
                          },
                          child: GetBuilder<ThemeController>(
                              builder: (_) {
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: TTTPrimary2,
                                      radius: deviceWidth * 0.05,
                                    ),
                                    themeController.selectedPrimaryColor == TTTPrimary2 ?
                                    Icon(
                                      Icons.check, size: deviceWidth * 0.1,
                                      color: TTTBlack,
                                    ) :
                                    Container(),
                                  ],
                                );
                              }
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            themeController.selectedPrimaryColor = TTTPrimary3;
                            themeController.refreshTheme();
                          },
                          child: GetBuilder<ThemeController>(
                              builder: (_) {
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: TTTPrimary3,
                                      radius: deviceWidth * 0.05,
                                    ),
                                    themeController.selectedPrimaryColor == TTTPrimary3 ?
                                    Icon(
                                      Icons.check, size: deviceWidth * 0.1,
                                      color: TTTBlack,
                                    ) :
                                    Container(),
                                  ],
                                );
                              }
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            themeController.selectedPrimaryColor = TTTPrimary4;
                            themeController.refreshTheme();
                          },
                          child: GetBuilder<ThemeController>(
                              builder: (_) {
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: TTTPrimary4,
                                      radius: deviceWidth * 0.05,
                                    ),
                                    themeController.selectedPrimaryColor == TTTPrimary4 ?
                                    Icon(
                                      Icons.check, size: deviceWidth * 0.1,
                                      color: TTTBlack,
                                    ) :
                                    Container(),
                                  ],
                                );
                              }
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            themeController.selectedPrimaryColor = TTTPrimary5;
                            themeController.refreshTheme();
                          },
                          child: GetBuilder<ThemeController>(
                              builder: (_) {
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: TTTPrimary5,
                                      radius: deviceWidth * 0.05,
                                    ),
                                    themeController.selectedPrimaryColor == TTTPrimary5 ?
                                    Icon(
                                      Icons.check, size: deviceWidth * 0.1,
                                      color: TTTWhite,
                                    ) :
                                    Container(),
                                  ],
                                );
                              }
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}