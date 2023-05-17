import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/controller/loading_controller.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import 'package:tickle_tackle_tockle/model/LoginReq.dart';

import '../../const/serveraddress.dart';
import '../../const/theme.dart';
import 'package:tickle_tackle_tockle/controller/loading_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentImageIndex = 0;
  List<String> backgroundImageList = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
  ];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startImageAnimation();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startImageAnimation() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        currentImageIndex = (currentImageIndex + 1) % backgroundImageList.length;
      });
    });
  }

  Future<UserCredential> googleAuthSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('deviceToken', token!);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/0.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(backgroundImageList[currentImageIndex]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            body: Center(
              child: SizedBox(
                height: deviceHeight * 0.07,
                width: deviceWidth * 0.8,
                child: ElevatedButton(
                  onPressed: () async {
                    loadingController.setIsLoadingFlag(true);
                    googleAuthSignIn().then((value) {
                      if(value != null) {
                        print('로그인 성공!!');


                      } else {
                        print('로그인실패!!!!!!');
                      }
                    }).whenComplete(() => loadingController.setIsLoadingFlag(false));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
                    side: const BorderSide(width: 2,),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: size.width * 0.06,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.1,
                      ),
                      const Text(
                        '구글로 로그인하기',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}