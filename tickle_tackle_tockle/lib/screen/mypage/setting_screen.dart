import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/screen/mypage/privacy_screen.dart';
import 'package:tickle_tackle_tockle/screen/mypage/tos_screen.dart';
import '../../const/theme.dart';
import 'menual_screen.dart';
import 'package:flutter/services.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;
    final menuFontSize = deviceHeight * 0.023;

    Future<void> signOutGoogle() async {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
    }

    return SafeArea(
      child: Scaffold(
        appBar: const CommonAppBar(appBarType: AppBarType.normalAppBar, title: '설정'),
        body: Padding(
          padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, deviceHeight * 0.02, deviceWidth * 0.05, 0),
          child: Container(
            height: deviceHeight * 0.3,
            width: deviceWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 5.0,
                  spreadRadius: 0.0,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(deviceHeight * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const PrivacyScreen(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '개인 정보 처리 방침',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: menuFontSize
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const TosScreen(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '이용 약관',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: menuFontSize
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ManualScreen(),
                        withNavBar: false,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '사용 안내',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: menuFontSize
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      signOutGoogle().then((value) => Navigator.pop(context));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '로그아웃',
                          style: TextStyle(
                              color: TTTPrimary1,
                              fontSize: menuFontSize
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      //await FirebaseAuth.instance.currentUser!.delete();
                      //await _resetApp(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '회원탈퇴',
                          style: TextStyle(
                              color: TTTPrimary1,
                              fontSize: menuFontSize
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}