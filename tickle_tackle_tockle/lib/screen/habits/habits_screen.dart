import 'package:flutter/material.dart';
import '../../component/common_appbar.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나의 습관 목록'),
      body: Center(child: Text('HabitsScreen', style: TextStyle(fontSize: 30),)),
    );
  }
}