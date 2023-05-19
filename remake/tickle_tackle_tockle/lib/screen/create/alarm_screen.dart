import 'package:flutter/material.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:get/get.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

import '../../const/theme.dart';
import '../../controller/create_habit_controller.dart';
import '../../controller/theme_controller.dart';


class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {

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
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('반복 설정', style: TextStyle(fontSize: 20,),),
                            GetBuilder<ThemeController>(
                              builder: (_) {
                                return SwitcherButton(
                                  offColor: TTTGrey,
                                  onColor: themeController.selectedPrimaryColor,
                                  value: createHabitController.isAlarmRepeat,
                                  onChange: (_) {
                                    setState(() {
                                      createHabitController.isAlarmRepeat = !createHabitController.isAlarmRepeat;
                                    });
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      createHabitController.isAlarmRepeat ? Column(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('시작 시간', style: TextStyle(fontSize: 20,),),
                                InkWell(
                                  onTap: () async {
                                    final result = await TimePicker.show<DateTime?>(
                                      context: super.context,
                                      sheet: TimePickerSheet(
                                        sheetTitle: '시작 시간',
                                        hourTitle: '시',
                                        minuteTitle: '분',
                                        saveButtonText: '저장',
                                        saveButtonColor: themeController.selectedPrimaryColor,
                                        minuteInterval: 1,
                                        initialDateTime: DateTime(0, 0, 0, int.parse(createHabitController.startTime.substring(0, 2)), int.parse(createHabitController.startTime.substring(2, 4))),
                                      ),
                                    );

                                    if(result != null) {
                                      int startHour = result.hour;
                                      int startMinute = result.minute;

                                      createHabitController.startTime = startHour.toString().padLeft(2, '0') + startMinute.toString().padLeft(2, '0');

                                      //저장 성공하면 갱신하도록
                                      themeController.refresh();
                                    }
                                  },
                                  child: GetBuilder<ThemeController>(
                                      builder: (_) {
                                        String strAlarm = '${createHabitController.startTime.substring(0, 2)}시 ${createHabitController.startTime.substring(2, 4)}분';
                                        return Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: themeController.selectedPrimaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              strAlarm,
                                              style: TextStyle(
                                                color: TTTWhite,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
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
                                Text('종료 시간', style: TextStyle(fontSize: 20,),),
                                InkWell(
                                  onTap: () async {
                                    final result = await TimePicker.show<DateTime?>(
                                      context: super.context,
                                      sheet: TimePickerSheet(
                                        sheetTitle: '종료 시간',
                                        hourTitle: '시',
                                        minuteTitle: '분',
                                        saveButtonText: '저장',
                                        saveButtonColor: themeController.selectedPrimaryColor,
                                        minuteInterval: 1,
                                        initialDateTime: DateTime(0, 0, 0, int.parse(createHabitController.endTime.substring(0, 2)), int.parse(createHabitController.endTime.substring(2, 4))),
                                      ),
                                    );

                                    if(result != null) {
                                      int endHour = result.hour;
                                      int endMinute = result.minute;

                                      createHabitController.endTime = endHour.toString().padLeft(2, '0') + endMinute.toString().padLeft(2, '0');

                                      themeController.refresh();
                                    }
                                  },
                                  child: GetBuilder<ThemeController>(
                                      builder: (_) {
                                        String strAlarm = '${createHabitController.endTime.substring(0, 2)}시 ${createHabitController.endTime.substring(2, 4)}분';
                                        return Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: themeController.selectedPrimaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              strAlarm,
                                              style: TextStyle(
                                                color: TTTWhite,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
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
                                Text('반복 주기', style: TextStyle(fontSize: 20,),),
                                InkWell(
                                  onTap: () async {
                                    final result = await TimePicker.show<DateTime?>(
                                      context: super.context,
                                      sheet: TimePickerSheet(
                                        sheetTitle: '반복 주기',
                                        hourTitle: '시간',
                                        minuteTitle: '분',
                                        saveButtonText: '저장',
                                        saveButtonColor: themeController.selectedPrimaryColor,
                                        minuteInterval: 1,
                                        initialDateTime: DateTime(0, 0, 0, int.parse(createHabitController.repeatTime.substring(0, 2)), int.parse(createHabitController.repeatTime.substring(2, 4))),
                                      ),
                                    );

                                    if(result != null) {
                                      int repeatHour = result.hour;
                                      int repeatMinute = result.minute;

                                      createHabitController.repeatTime = repeatHour.toString().padLeft(2, '0') + repeatMinute.toString().padLeft(2, '0');

                                      themeController.refresh();

                                      //반복주기 0 분에 대한 예외처리는 ?
                                    }
                                  },
                                  child: GetBuilder<ThemeController>(
                                      builder: (_) {
                                        String strAlarm = '${createHabitController.repeatTime.substring(0, 2)}시간 ${createHabitController.repeatTime.substring(2, 4)}분 마다';
                                        return Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: themeController.selectedPrimaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              strAlarm,
                                              style: TextStyle(
                                                color: TTTWhite,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ) : Column(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('알람 시간', style: TextStyle(fontSize: 20,),),
                                InkWell(
                                  onTap: () async {
                                    final result = await TimePicker.show<DateTime?>(
                                      context: super.context,
                                      sheet: TimePickerSheet(
                                        sheetTitle: '알람 시간',
                                        hourTitle: '시',
                                        minuteTitle: '분',
                                        saveButtonText: '저장',
                                        saveButtonColor: themeController.selectedPrimaryColor,
                                        minuteInterval: 1,
                                        initialDateTime: DateTime(0, 0, 0, int.parse(createHabitController.alarmTime.substring(0, 2)), int.parse(createHabitController.alarmTime.substring(2, 4))),
                                      ),
                                    );

                                    if(result != null) {
                                      int alarmHour = result.hour;
                                      int alarmMinute = result.minute;

                                      createHabitController.alarmTime = alarmHour.toString().padLeft(2, '0') + alarmMinute.toString().padLeft(2, '0');

                                      themeController.refresh();
                                    }
                                  },
                                  child: GetBuilder<ThemeController>(
                                      builder: (_) {
                                        String strAlarm = '${createHabitController.alarmTime.substring(0, 2)}시 ${createHabitController.alarmTime.substring(2, 4)}분';
                                        return Container(
                                          height: 30,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: themeController.selectedPrimaryColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: Text(
                                              strAlarm,
                                              style: TextStyle(
                                                color: TTTWhite,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
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