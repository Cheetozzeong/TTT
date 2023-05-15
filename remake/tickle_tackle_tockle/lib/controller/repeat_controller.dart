import 'package:get/get.dart';

class RepeatController extends GetxController {
  bool _isRepeat = false;
  bool get isRepeat => _isRepeat;

  void setIsRepeatFlag(bool value) {
    _isRepeat = value;
    update();
  }
}