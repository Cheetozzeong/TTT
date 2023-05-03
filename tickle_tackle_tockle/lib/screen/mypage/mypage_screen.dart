import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tickle_tackle_tockle/component/common_appbar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deviceWidth = size.width;
    final deviceHeight = size.height;

    return Scaffold(
      appBar: CommonAppBar(appBarType: AppBarType.myPageAppBar, title: '마이 페이지',),
      body: Padding(
        padding: EdgeInsets.fromLTRB(deviceWidth * 0.05, deviceHeight * 0.02, deviceWidth * 0.05, 0),
        child: Container(
          height: deviceHeight * 0.15,
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
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: deviceWidth * 0.085,
                  backgroundImage: CachedNetworkImageProvider(FirebaseAuth.instance.currentUser!.photoURL.toString()),
                ),
                SizedBox(
                  width: deviceWidth * 0.05,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: deviceWidth * 0.5,
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: deviceWidth * 0.06
                        ),
                      ),
                    ),
                    Container(
                      width: deviceWidth * 0.5,
                      child: Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}