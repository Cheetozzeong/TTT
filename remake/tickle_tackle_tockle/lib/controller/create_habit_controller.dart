import 'package:get/get.dart';

class CreateHabitController extends GetxController {
  String emoji = '😀';
  String repeatWeek = '1000000';
  String category = '금전';
  String name = '';
  bool isAlarmRepeat = false;
  String alarmTime = '0000';
  String startTime = '0000';
  String endTime = '0000';
  String repeatTime = '0000';


  initValue() {
    emoji = '😀';
    repeatWeek = '1000000';
    category = '금전';
    name = '';
    isAlarmRepeat = false;
    alarmTime = '0000';
    startTime = '0000';
    endTime = '0000';
    repeatTime = '0000';
  }

  changeAlarmState(bool value) {
    isAlarmRepeat = value;
    update();
  }
}