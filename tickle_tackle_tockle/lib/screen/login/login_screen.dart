import 'package:flutter/material.dart';

//Const
import '../../const/theme.dart';

//Controller
import 'package:tickle_tackle_tockle/controller/loading_controller.dart';

//Firebase
import 'package:firebase_auth/firebase_auth.dart';

//Widget
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Future<UserCredential> googleAuthSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          '로그인 하기',
          style: TextStyle(
            color: TTTPrimary1,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            loadingController.setIsLoadingFlag(true);
            googleAuthSignIn().then((value) => loadingController.setIsLoadingFlag(false));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              side: const BorderSide(
                  width: 2, color: Color.fromARGB(255, 100, 92, 170))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset(
                'assets/images/google_logo.png',
                width: size.width * 0.06,
              ),
              Text(
                '구글로 로그인하기',
                style: TextStyle(
                    fontFamily: 'bmjua',
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 80, 78, 91),
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}