import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/const/theme.dart';

class HideScreen extends StatelessWidget {
  const HideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '토끌 아지트',),
        body: Center(
          child: Text('ㅎㅎ', style: TextStyle(color: TTTPrimary1),),
        ),
      ),);
  }
}
