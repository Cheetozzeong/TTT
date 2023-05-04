import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import '../../const/theme.dart';
import 'package:tickle_tackle_tockle/controller/loading_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';


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
                onPressed: () {
                  loadingController.setIsLoadingFlag(true);
                  googleAuthSignIn().whenComplete(() => loadingController.setIsLoadingFlag(false));
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