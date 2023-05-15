import 'package:get/get.dart';

class CreateHabitController extends GetxController {
  String emoji = '';
  String repeatWeek = '1000000';
  String category = '금전';

  initValue() {
    emoji = '';
    repeatWeek = '1000000';
    category = '금전';
  }
}