import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/controller/normal_alarm_controller.dart';

import '../../const/theme.dart';
import '../../controller/loading_controller.dart';
import '../../controller/repeat_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:get/get.dart';

import 'habit_edit_category_screen.dart';
import 'habits_alarm_screen.dart';

class HabitsAlarmScreen extends StatelessWidget {
  const HabitsAlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());
    NormalAlarmController normalAlarmController = Get.put(NormalAlarmController());
    RepeatController repeatController = Get.put(RepeatController());

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '알람 시간 설정'),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(20.0 , 10.0, 20.0, 10.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('반복설정', style: TextStyle(fontSize: 20,),),
                  GetBuilder<ThemeController>(
                      builder: (_) {
                        return GetBuilder<NormalAlarmController>(
                            builder: (_) {
                              return SwitcherButton(
                                  offColor: TTTGrey,
                                  onColor: themeController.selectedPrimaryColor,
                                  size: 50,
                                  value: normalAlarmController.isAlarm,
                                  onChange: (_) {
                                    normalAlarmController.setIsAlarmFlag(!normalAlarmController.isAlarm);
                                  }
                              );
                            }
                        );
                      }
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTPrimary1, width: 2.0),
                    ),
                    child: Text('일', style: TextStyle(color: TTTPrimary1,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTWhite, width: 2.0),
                    ),
                    child: Text('월', style: TextStyle(color: TTTBlack,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTPrimary1, width: 2.0),
                    ),
                    child: Text('화', style: TextStyle(color: TTTBlack,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTWhite, width: 2.0),
                    ),
                    child: Text('수', style: TextStyle(color: TTTBlack,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTWhite, width: 2.0),
                    ),
                    child: Text('목', style: TextStyle(color: TTTBlack,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTWhite, width: 2.0),
                    ),
                    child: Text('금', style: TextStyle(color: TTTBlack,)),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      border: Border.all(color: TTTWhite, width: 2.0),
                    ),
                    child: Text('토', style: TextStyle(color: TTTPrimary1,)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.fromLTRB(20.0 , 10.0, 20.0, 10.0),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('카테고리', style: TextStyle(fontSize: 20,),),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const HabitEditCategoryScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_exercise_small.png'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}