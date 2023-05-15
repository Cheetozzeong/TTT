import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';

import '../../const/theme.dart';
import '../../controller/create_habit_controller.dart';
import '../../controller/theme_controller.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    ThemeController themeController = Get.put(ThemeController());
    CreateHabitController createHabitController = Get.put(CreateHabitController());

    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '알람 시간 설정',),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
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
