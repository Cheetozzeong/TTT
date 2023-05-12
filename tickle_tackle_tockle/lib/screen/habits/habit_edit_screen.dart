import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';

import '../../const/theme.dart';
import '../../controller/loading_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:get/get.dart';

import 'habit_edit_category_screen.dart';
import 'habits_alarm_screen.dart';

class HabitEditScreen extends StatelessWidget {
  const HabitEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '내 습관'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
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
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(Icons.ac_unit_outlined),
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
                        Text('알람', style: TextStyle(fontSize: 20,),),
                        SizedBox(
                          height: deviceHeight * 0.05,
                          width: deviceWidth * 0.5,
                          child: ElevatedButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const HabitsAlarmScreen(),
                                withNavBar: false,
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(TTTPrimary1),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )
                              ),
                            ),
                            child: Text('시간 설정', style: TextStyle(fontSize: deviceHeight * 0.02,), textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('  습관 반복 요일', style: TextStyle(fontSize: 20,),),
                    ],
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
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: GetBuilder<ThemeController>(
                builder: (_) {
                  return Container(
                    width: deviceWidth,
                    height: deviceHeight * 0.1,
                    color: themeController.selectedPrimaryColor,
                    child: Center(child: Text('완료', style: TextStyle(color: TTTWhite, fontSize: 20),)),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}