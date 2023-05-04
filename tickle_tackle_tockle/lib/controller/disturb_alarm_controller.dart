import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';

class DisturbAlarmController extends GetxController {
  bool _isDisturbAlarm = false;
  bool get isDisturbAlarm => _isDisturbAlarm;

  Color stateColor = TTTPrimary1;

  void setIsDisturbAlarmFlag(bool value, Color color) {
    _isDisturbAlarm = value;

    if(value) {
      stateColor = color;
    } else {
      stateColor = TTTGrey;
    }

    update();
  }
}