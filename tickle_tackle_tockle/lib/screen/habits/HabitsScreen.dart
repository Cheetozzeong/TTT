import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('HabitsScreen', style: TextStyle(fontSize: 30),)),
    );
  }
}