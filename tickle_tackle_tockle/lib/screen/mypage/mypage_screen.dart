import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/component/custom_switch.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import 'package:tickle_tackle_tockle/controller/disturb_alarm_controller.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  setSharedPreferenceTheme(Color selectedColor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeColor', selectedColor.value);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    ThemeController themeController = Get.put(ThemeController());
    DisturbAlarmController disturbAlarmController = Get.put(DisturbAlarmController());

    buildButtonWidget(BuildContext buildContext, ExpandableController ec) {
      return Builder(
        builder: (buildContext) {
          return GetBuilder<ThemeController>(
            builder: (_) {
              return GetBuilder<DisturbAlarmController>(
                builder: (_) {
                  return CustomSwitch(
                    value: disturbAlarmController.isDisturbAlarm,
                    disableColor: disturbAlarmController.stateColor,
                    enableColor: disturbAlarmController.stateColor,
                    switchHeight: 20,
                    switchWidth: deviceWidth * 0.15,
                    onChanged: (_) {
                      ec.toggle();
                      disturbAlarmController.setIsDisturbAlarmFlag(!disturbAlarmController.isDisturbAlarm, themeController.selectedPrimaryColor);
                    },
                  );
                }
              );
            }
          );
        },
      );
    }

    buildCollapsedAlarm(BuildContext buildContext, ExpandableController ec) {
      return Container(
        height: deviceHeight * 0.08,
        width: deviceWidth * 0.9,
        child: Padding(
          padding: EdgeInsets.all(deviceHeight * 0.022),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '방해 금지 시간대 설정',
                style: TextStyle(
                  fontSize: deviceWidth * 0.055,
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.14,
              ),
              Container(
                height: deviceHeight * 0.03,
                child: buildButtonWidget(buildContext, ec),
              ),
            ],
          ),
        ),
      );
    }

    buildExpandedAlarm(BuildContext buildContext, ExpandableController ec) {
      return Container(
        height: deviceHeight * 0.2,
        width: deviceWidth * 0.9,
        child: Padding(
          padding: EdgeInsets.all(deviceHeight * 0.022),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '방해 금지 시간대 설정',
                style: TextStyle(
                  fontSize: deviceWidth * 0.055,
                ),
              ),
              SizedBox(
                width: deviceWidth * 0.14,
              ),
              Container(
                height: deviceHeight * 0.03,
                child: buildButtonWidget(buildContext, ec),
              ),
            ],
          ),
        ),
      );
    }


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
                            setSharedPreferenceTheme(TTTPrimary1);
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
                            setSharedPreferenceTheme(TTTPrimary2);
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
                            setSharedPreferenceTheme(TTTPrimary3);
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
                            setSharedPreferenceTheme(TTTPrimary4);
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
                            setSharedPreferenceTheme(TTTPrimary5);
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
            SizedBox(
              height: deviceHeight * 0.02,
            ),
            Container(
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
              child: ExpandableNotifier(
                child: Expandable(
                  collapsed: Builder(
                    builder: (context) {
                      var exController = ExpandableController.of(context, required: true)!;
                      return buildCollapsedAlarm(context, exController);
                    },
                  ),
                  expanded: Builder(
                    builder: (context) {
                      var exController = ExpandableController.of(context, required: true)!;
                      return buildExpandedAlarm(context, exController);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}