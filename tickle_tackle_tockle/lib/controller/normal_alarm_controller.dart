import 'package:get/get.dart';

class NormalAlarmController extends GetxController {
  bool _isAlarm = false;
  bool get isAlarm => _isAlarm;

  void setIsAlarmFlag(bool value) {
    _isAlarm = value;
    update();
  }
}