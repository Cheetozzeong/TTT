import 'dart:convert';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/controller/edit_habit_controller.dart';

import '../../const/serveraddress.dart';
import '../../const/theme.dart';
import '../../controller/create_habit_controller.dart';
import '../../controller/loading_controller.dart';
import '../../controller/page_change_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:get/get.dart';

import '../../model/HabitReq.dart';
import 'habit_edit_category_screen.dart';
import 'habits_alarm_screen.dart';
import 'package:http/http.dart' as http;


class HabitEditScreen extends StatefulWidget {
  const HabitEditScreen({Key? key}) : super(key: key);

  @override
  State<HabitEditScreen> createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends State<HabitEditScreen> {

  TextEditingController _nameController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());
  PageChangeController pageChangeController = Get.put(PageChangeController());
  EditHabitController editHabitController = Get.put(EditHabitController());


  Future<http.Response> sendAccessToken(HabitReq habitReq) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/habit');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,
      },
      body: json.encode(habitReq.toJson()),
    );
    return response;
  }

  Future<void> checkAccessToken(HabitReq habitReq) async {

    final response = await sendAccessToken(habitReq);

    if (response.statusCode == 200) {
      print('성공했지로옹');
    }else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/habit');
      var response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accesstoken' : accessToken,
          'refreshtoken' :  refreshToken,
        },
        body: json.encode(habitReq.toJson()),
      );
      final headers = response.headers;
      final accesstoken = headers['accesstoken'];
      final refreshtoken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accesstoken!);
      sharedPreferences.setString('refreshToken', refreshtoken!);
    }else print('Login failed with status: ${response.statusCode}');

  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    _nameController = TextEditingController(text: editHabitController.name);

    late Widget categoryImgWidget;
    switch(editHabitController.category) {
      case '금전': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_money_small.png'); break;
      case '운동': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_exercise_small.png'); break;
      case '학습': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_study_small.png'); break;
      case '관계': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_relationship_small.png'); break;
      case '생활': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_life_small.png'); break;
      case '기타': categoryImgWidget = Image.asset('assets/images/buttons/categoryBtnIcon_etc_small.png'); break;
    }

    void replaceWeekString(int weekIdx) {
      FocusManager.instance.primaryFocus?.unfocus();
      String strReplace = editHabitController.repeatWeek[weekIdx];

      if(strReplace == '0') {
        strReplace = '1';
      } else {
        strReplace = '0';
      }

      String resultWeekString = editHabitController.repeatWeek.replaceRange(weekIdx, weekIdx + 1, strReplace);

      if(resultWeekString == '0000000') {
        Fluttertoast.showToast(
            msg: "요일은 한 개 이상 설정해주세요!",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xff6E6E6E),
            fontSize: deviceWidth * 0.04,
            toastLength: Toast.LENGTH_SHORT);
      } else {
        editHabitController.repeatWeek = resultWeekString;
        themeController.refreshTheme();
      }
    }

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나만의 습관 생성',),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (_) {
                                      return EmojiPicker(
                                        onEmojiSelected: (category, emoji) {
                                          editHabitController.emoji = emoji.emoji;
                                          themeController.refreshTheme();
                                          Navigator.pop(context);
                                        },
                                        config: const Config(
                                          columns: 7,
                                          emojiSizeMax: 20,
                                          verticalSpacing: 10,
                                          horizontalSpacing: 10,
                                          gridPadding: EdgeInsets.all(5.0),
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
                                      );
                                    }
                                );
                              },
                              child: GetBuilder<ThemeController>(
                                  builder: (_) {
                                    return CircleAvatar(
                                      maxRadius: 25,
                                      backgroundColor: TTTWhite,

                                      child: Text(editHabitController.emoji, style: TextStyle(fontSize: 25),),
                                    );
                                  }
                              ),
                            ),
                            SizedBox(width: 20,),
                            Text('습관을 대표할 이모지를 설정해주세요!'),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
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
                                    child: SizedBox(height: 50, width: deviceWidth,),
                                  ),
                                  SizedBox(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: '습관 이름을 입력해주세요!'
                                      ),
                                      maxLength: 12,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      controller: _nameController,
                                      onChanged: (value) {
                                        editHabitController.name = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('알람', style: TextStyle(fontSize: 20,),),
                              SizedBox(
                                height: 40,
                                width: 150,
                                child: GetBuilder<ThemeController>(
                                    builder: (_) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: const HabitsAlarmScreen(),
                                            withNavBar: false,
                                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(themeController.selectedPrimaryColor),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              )
                                          ),
                                        ),
                                        child: Text('시간 설정', style: TextStyle(fontSize: 17,), textAlign: TextAlign.center),
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
                                            color: editHabitController.repeatWeek[0] == '1'
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
                                            color: editHabitController.repeatWeek[1] == '1'
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
                                            color: editHabitController.repeatWeek[2] == '1'
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
                                            color: editHabitController.repeatWeek[3] == '1'
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
                                            color: editHabitController.repeatWeek[4] == '1'
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
                                            color: editHabitController.repeatWeek[5] == '1'
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
                                            color: editHabitController.repeatWeek[6] == '1'
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
                              InkWell(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const HabitEditCategoryScreen(),
                                        withNavBar: false,
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                },
                                child: SizedBox(
                                  height: 60,
                                  width: 130,
                                  child: categoryImgWidget,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if(editHabitController.name.length == 0) {
                    Fluttertoast.showToast(
                        msg: "이름을 입력해주세요!",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: const Color(0xff6E6E6E),
                        fontSize: deviceWidth * 0.04,
                        toastLength: Toast.LENGTH_SHORT);

                    return;
                  }
                  //꺼져있을때
                  if(editHabitController.isAlarmRepeat == false) {
                    editHabitController.repeatTime = '2400';
                    editHabitController.startTime = editHabitController.endTime = editHabitController.alarmTime;
                  }
                  String category = editHabitController.category;
                  int categoryNum = 0;

                  switch(category){
                    case '금전': categoryNum =0; break;
                    case '운동': categoryNum =1; break;
                    case '학습': categoryNum =2; break;
                    case '관계': categoryNum =3; break;
                    case '생활': categoryNum =4; break;
                    case '기타': categoryNum =5; break;
                  }

                  print('호히호히 : $category !! $categoryNum');

                  HabitReq habitReq = new HabitReq(
                    id : editHabitController.id,
                    categoryId: categoryNum,
                    name: editHabitController.name,
                    emoji: editHabitController.emoji,
                    startTime: editHabitController.startTime,
                    endTime: editHabitController.endTime,
                    term: editHabitController.repeatTime,
                    repeatDay: editHabitController.repeatWeek,
                  );

                  checkAccessToken(habitReq).then((value) {
                    pageChangeController.rebuildPage();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
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
      ),
    );
  }
}