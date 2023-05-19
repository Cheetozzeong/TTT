import 'package:get/get.dart';

class EditHabitController extends GetxController {
  int id = 0;
  String emoji = '😀';
  String repeatWeek = '0000000';
  String category = '금전';
  String name = '';
  bool isAlarmRepeat = false;
  String alarmTime = '0000';
  String startTime = '0000';
  String endTime = '0000';
  String repeatTime = '0000';

  changeAlarmState(bool value) {
    isAlarmRepeat = value;
    update();
  }
}