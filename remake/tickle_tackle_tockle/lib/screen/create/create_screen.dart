import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/controller/create_habit_controller.dart';

import '../../const/theme.dart';
import '../../controller/theme_controller.dart';
import 'alarm_screen.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    ThemeController themeController = Get.put(ThemeController());
    CreateHabitController createHabitController = Get.put(CreateHabitController());

    late Widget categoryImgWidget;
    switch(createHabitController.category) {
      case '금전': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_money_small.png'); break;
      case '운동': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_exercise_small.png'); break;
      case '학습': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_study_small.png'); break;
      case '관계': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_relationship_small.png'); break;
      case '생활': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_life_small.png'); break;
      case '기타': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_etc_small.png'); break;
    }

    void replaceWeekString(int weekIdx) {
      String strReplace = createHabitController.repeatWeek[weekIdx];

      if(strReplace == '0') {
        strReplace = '1';
      } else {
        strReplace = '0';
      }

      String resultWeekString = createHabitController.repeatWeek.replaceRange(weekIdx, weekIdx + 1, strReplace);

      if(resultWeekString == '0000000') {
        Fluttertoast.showToast(
            msg: "요일은 한 개 이상 설정해주세요!",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xff6E6E6E),
            fontSize: deviceWidth * 0.04,
            toastLength: Toast.LENGTH_SHORT);
      } else {
        createHabitController.repeatWeek = resultWeekString;
        themeController.refreshTheme();
      }
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나만의 습관 생성',),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_) {
                              return Center(
                                child: SizedBox(
                                  width: deviceWidth * 0.8,
                                  height: deviceHeight * 0.5,
                                  child: Card(
                                    child: EmojiPicker(
                                      onEmojiSelected: (category, emoji) {

                                      },
                                      config: const Config(
                                        columns: 7,
                                        emojiSizeMax: 50,
                                        verticalSpacing: 10,
                                        horizontalSpacing: 10,
                                        gridPadding: EdgeInsets.zero,
                                        initCategory: Category.RECENT,
                                        bgColor: Color(0xFFF2F2F2),
                                        indicatorColor: Colors.blue,
                                        iconColor: Colors.grey,
                                        iconColorSelected: Colors.blue,
                                        backspaceColor: Colors.blue,
                                        skinToneDialogBgColor: Colors.white,
                                        skinToneIndicatorColor: Colors.grey,
                                        enableSkinTones: true,
                                        showRecentsTab: true,
                                        recentsLimit: 28,
                                        noRecents: Text(
                                          'No Recents',
                                          style: TextStyle(fontSize: 20, color: Colors.black26),
                                          textAlign: TextAlign.center,
                                        ), // Needs to be const Widget
                                        loadingIndicator: SizedBox.shrink(), // Needs to be const Widget
                                        tabIndicatorAnimDuration: kTabScrollDuration,
                                        categoryIcons: CategoryIcons(),
                                        buttonMode: ButtonMode.MATERIAL,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: GetBuilder<ThemeController>(
                          builder: (_) {
                            return Container(
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
                              child: Text(createHabitController.emoji),
                            );
                          }
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        width: deviceWidth * 0.7,
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('알람', style: TextStyle(fontSize: 20,),),
                        SizedBox(
                          height: deviceHeight * 0.05,
                          width: deviceWidth * 0.5,
                          child: GetBuilder<ThemeController>(
                            builder: (_) {
                              return ElevatedButton(
                                onPressed: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const AlarmScreen(),
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
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('습관 반복 요일', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                    child: GetBuilder<ThemeController>(
                      builder: (_) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                replaceWeekString(0);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[0] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('일', style: TextStyle(color: TTTPrimary1,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(1);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[1] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('월', style: TextStyle(color: TTTBlack,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(2);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[2] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('화', style: TextStyle(color: TTTBlack,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(3);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[3] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('수', style: TextStyle(color: TTTBlack,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(4);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[4] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,),
                                ),
                                child: Text('목', style: TextStyle(color: TTTBlack,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(5);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[5] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('금', style: TextStyle(color: TTTBlack,)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                replaceWeekString(6);
                              },
                              child: Container(
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
                                  border: Border.all(
                                    color: createHabitController.repeatWeek[6] == '1'
                                        ? themeController.selectedPrimaryColor : TTTWhite,
                                    width: 2.0,
                                  ),
                                ),
                                child: Text('토', style: TextStyle(color: TTTPrimary1,)),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
                              Navigator.pop(context);
                              /*PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const HabitEditCategoryScreen(),
                                withNavBar: false,
                                pageTransitionAnimation: PageTransitionAnimation.cupertino,
                              );*/
                            },
                            child: categoryImgWidget,
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
                      child: Center(child: Text('생성하기', style: TextStyle(color: TTTWhite, fontSize: 20),)),
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
