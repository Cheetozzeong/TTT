import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import '../../component/common_appbar.dart';
import '../../controller/loading_controller.dart';
import '../../controller/theme_controller.dart';
import 'package:get/get.dart';

import 'habit_edit_screen.dart';


class HabitsScreen extends StatelessWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  buildWeekRow({
    bool sun = false,
    bool mon = false,
    bool tue = false,
    bool wed = false,
    bool thu = false,
    bool fri = false,
    bool sat = false,
    Color themeColor = TTTPrimary1
  }) {
    const double checkMaxRadius = 10;
    const double checkMinRadius = 8;
    const double checkFontSize = 10;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          backgroundColor: sun ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('일', style: TextStyle(color: TTTPrimary1, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: mon ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('월', style: TextStyle(color: TTTBlack, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: tue ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('화', style: TextStyle(color: TTTBlack, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: wed ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('수', style: TextStyle(color: TTTBlack, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: thu ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('목', style: TextStyle(color: TTTBlack, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: fri ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('금', style: TextStyle(color: TTTBlack, fontSize: checkFontSize,)),
          ),
        ),
        CircleAvatar(
          backgroundColor: sat ? themeColor : TTTWhite,
          maxRadius: checkMaxRadius,
          child: const CircleAvatar(
            backgroundColor: TTTWhite,
            maxRadius: checkMinRadius,
            child: Text('토', style: TextStyle(color: TTTPrimary1, fontSize: checkFontSize,)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나의 습관 목록'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('운동', style: TextStyle(fontSize: 25,)),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              InkWell(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const HabitEditScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Container(
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
                      Icon(Icons.ac_unit_outlined),
                      GetBuilder<ThemeController>(
                        builder: (_) {
                          return Column(
                            children: [
                              Text('달리기', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5,),
                              buildWeekRow(sun: true, mon: true, fri: true, themeColor: themeController.selectedPrimaryColor),
                            ],
                          );
                        }
                      ),
                      GetBuilder<ThemeController>(
                        builder: (_) {
                          return Text('12 티끌', style: TextStyle(color: themeController.selectedPrimaryColor),);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*children: [
              Text('운동', style: TextStyle(fontSize: 25,)),
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
                child: Text('sd'),
              ),
            ],*/