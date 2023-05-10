import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.normalAppBar, title: '워치와 연결'),
      body: Container(),
    );
  }
}
