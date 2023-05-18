import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '카테고리 선택',),
        body: Center(
          child: Text(
            '카테고리 선택',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
