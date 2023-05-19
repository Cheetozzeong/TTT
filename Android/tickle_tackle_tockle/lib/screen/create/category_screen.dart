import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import '../../controller/create_habit_controller.dart';
import 'create_screen.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    CreateHabitController createHabitController = Get.put(CreateHabitController());

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '카테고리 선택'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: deviceHeight * 0.2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '금전';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_money.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '운동';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_exercise.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '학습';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_study.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '관계';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_relationship.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '생활';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_life.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        createHabitController.category = '기타';

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: CreateScreen(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_etc.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

