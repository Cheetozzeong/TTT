import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';
import 'common_appbar.dart';

class HideScreen extends StatefulWidget {
  const HideScreen({Key? key}) : super(key: key);

  @override
  State<HideScreen> createState() => _HideScreenState();
}

class _HideScreenState extends State<HideScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '토끌의 아지트'),
        body: Center(
          child: Text('ㅎㅎ', style: TextStyle(color: TTTPrimary1),),
        ),
      ),);
  }
}