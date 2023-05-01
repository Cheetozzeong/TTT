import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';
import 'package:tickle_tackle_tockle/screen/mypage/privacy_screen.dart';
import 'package:tickle_tackle_tockle/screen/mypage/tos_screen.dart';
import '../../const/theme.dart';
import '../../main.dart';
import 'menual_screen.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;
    final menuFontSize = deviceHeight * 0.023;

    Future<void> clearApplicationData() async {
      Directory appDir = await getApplicationSupportDirectory();

      if (appDir.existsSync()) {
        // 앱 내부 데이터 경로에 있는 모든 파일 삭제
        appDir.deleteSync(recursive: true);
      }
    }

    /*void clearSqliteDatabase() async {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database_name.db');
      await deleteDatabase(path);
    }*/


    /*Future<void> clearAppData() async {
      final cache = await getTemporaryDirectory(); // 캐시 폴더 호출
      final appDir = await cache.parent; // App Data 삭제를 위해 캐시 폴더의 부모 폴더 호출
      if (await appDir.exists()) {
        final children = await appDir.list().toList();
        for (final s in children) {
          // App Data 폴더의 리스트를 deleteDir 를 통해 하위 디렉토리 삭제
          await deleteDir(s);
        }
      }
    }

    Future<bool> deleteDir(FileSystemEntity dir) async {
      if (dir is Directory) {
        final children = await dir.list().toList();

        // 파일 리스트를 반복문으로 호출
        for (final child in children) {
          final success = await deleteDir(child);
          if (!success) {
            return false;
          }
        }
      }

      // 디렉토리가 비어있거나 파일이므로 삭제 처리
      return await dir.delete();
    }*/

    Future<void> clearAppData() async {
      Directory appDir = await getApplicationSupportDirectory();
      if (await appDir.exists()) {
        List<FileSystemEntity> children = appDir.listSync(recursive: true);
        for (FileSystemEntity child in children) {
          await child.delete(recursive: true);
        }
      }

      Directory cacheDir = await getTemporaryDirectory();
      if (await cacheDir.exists()) {
        List<FileSystemEntity> children = cacheDir.listSync(recursive: true);
        for (FileSystemEntity child in children) {
          await child.delete(recursive: true);
        }
      }

      //clearSqliteDatabase();
    }

    Future<void> signOutGoogle() async {
      FirebaseAuth.instance.signOut().then((value) {
        FirebaseAuth.instance.authStateChanges().listen((User? user) { }).cancel();
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Directory appDocDir = await getApplicationSupportDirectory();

      if (await appDocDir.exists()) {
        await appDocDir.delete(recursive: true);
      }


      await clearApplicationData();

      await FirebaseAuth.instance.signOut();

      await clearAppData();

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),);
    }

    /*Future<void> _resetApp(BuildContext context) async {

      //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),);
    }*/

    /*final _auth = FirebaseAuth.instance;

    void signOut() async {
      await _auth.signOut().whenComplete(() => print('로그아웃 완료'));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),);
    }*/

    /*final _auth = FirebaseAuth.instance;

    Future<void> clearAppData() async {
      await _auth.currentUser!.delete();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      await _auth.signOut().whenComplete(() => print('로그아웃 완료'));
      await GoogleSignIn().
      final directory = await getApplicationSupportDirectory();
      await directory.delete(recursive: true).whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),));
    }*/



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
                      /*signOutGoogle();
                      final storage = FlutterSecureStorage();
                      await storage.deleteAll();
                      await FlutterSecureStorage().deleteAll();*/
                      //await signOutGoogle();
                      //await _resetApp(context);
                      //signOut();
                      //clearAppData();
                      signOutGoogle();
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