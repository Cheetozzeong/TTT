import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../component/common_appbar.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '나의 토끌이들'),
      body: Center(child: Text('RewardScreen', style: TextStyle(fontSize: 30),)),
    );
  }
}