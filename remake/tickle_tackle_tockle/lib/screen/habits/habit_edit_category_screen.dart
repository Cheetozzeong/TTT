import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tickle_tackle_tockle/controller/edit_habit_controller.dart';
import 'package:get/get.dart';
import '../../component/common_appbar.dart';

class HabitEditCategoryScreen extends StatelessWidget {
  const HabitEditCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;
    
    EditHabitController editHabitController = Get.put(EditHabitController());

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
                        editHabitController.category = '금전';

                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_money.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        editHabitController.category = '운동';

                        Navigator.of(context).pop();
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
                        editHabitController.category = '학습';

                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_study.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        editHabitController.category = '관계';

                        Navigator.of(context).pop();
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
                        editHabitController.category = '생활';

                        Navigator.of(context).pop();
                      },
                      child: Image.asset('assets/images/buttons/categoryBtnIcon_life.png'),
                    ),
                  ),
                  SizedBox(
                    width: deviceWidth * 0.47,
                    child: InkWell(
                      onTap: () {
                        editHabitController.category = '기타';

                        Navigator.of(context).pop();
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
