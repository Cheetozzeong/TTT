import 'package:get/get.dart';

class DisturbAlarmController extends GetxController {
  bool _isDisturbAlarm = false;
  bool get isDisturbAlarm => _isDisturbAlarm;

  void setIsDisturbAlarmFlag(bool value) {
    _isDisturbAlarm = value;
    update();
  }
}