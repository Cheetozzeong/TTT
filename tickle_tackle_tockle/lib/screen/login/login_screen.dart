import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import '../../const/serveraddress.dart';
import '../../const/theme.dart';
import 'package:tickle_tackle_tockle/controller/loading_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/LoginReq.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<UserCredential> googleAuthSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();

    SharedPreferences hsaredPreferences = await SharedPreferences.getInstance();
    hsaredPreferences.setString('token', token!);

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> saveIdToken() async {
    String str = await FirebaseAuth.instance.currentUser!.getIdToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('idToken', str!);
  }

  Future<http.Response> sendIdToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String idToken = pref.getString('idToken')!;
    var url = Uri.parse('${ServerUrl}/login');
    var loginReq = LoginReq(idToken: idToken);
    var body = json.encode(loginReq.toJson());
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: body,
    );
    return response;
  }

  void checkIdToken() async {

    final response = await sendIdToken();
    if (response.statusCode == 200) {
      final headers = response.headers;
      final accessToken = headers['accesstoken'];
      final refreshToken = headers['refreshtoken'];
      print('Access Token: $accessToken');
      print('Refresh Token: $refreshToken');
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accesstoken', accessToken!);
      sharedPreferences.setString('refreshtoken', refreshToken!);

    } else {
      print('${ServerUrl}/login');
      print('Login failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    return GetBuilder<ThemeController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text(
              '로그인 하기',
              style: TextStyle(
                color: themeController.selectedPrimaryColor,
              ),
            ),
            backgroundColor: Colors.white,
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
                      saveIdToken().then((value) => checkIdToken());

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
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}