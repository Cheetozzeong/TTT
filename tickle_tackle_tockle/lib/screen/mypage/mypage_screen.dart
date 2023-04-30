import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.myPageAppBar, title: '마이 페이지'),
      body: Center(child: Text('MyPageScreen', style: TextStyle(fontSize: 30),)),
    );
  }
}