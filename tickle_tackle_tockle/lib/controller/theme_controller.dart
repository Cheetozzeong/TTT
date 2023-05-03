import 'dart:ui';
import 'package:get/get.dart';
import '../const/theme.dart';

class ThemeController extends GetxController {
  Color selectedPrimaryColor = TTTPrimary1;

  void refreshTheme() {
    update();
  }
}