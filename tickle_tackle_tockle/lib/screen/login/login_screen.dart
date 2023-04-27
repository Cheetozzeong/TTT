import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            googleAuthSignIn();
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );*/

          },
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
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              side: const BorderSide(
                  width: 2, color: Color.fromARGB(255, 100, 92, 170))),
        ),
      ),
    );
  }
}