import 'package:flutter/material.dart';

import '../../component/common_appbar.dart';

class HabitEditCategoryScreen extends StatelessWidget {
  const HabitEditCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

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
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_money.png'),),
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_exercise.png'),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_study.png'),),
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_relationship.png'),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_life.png'),),
                  SizedBox(width: deviceWidth * 0.47, child: Image.asset('assets/images/buttons/categoryBtnIcon_etc.png'),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
