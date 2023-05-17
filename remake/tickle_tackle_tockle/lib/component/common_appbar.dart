import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:get/get.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import 'package:tickle_tackle_tockle/screen/mypage/menual_screen.dart';
import '../const/theme.dart';
import '../screen/camera/camera_screen.dart';
import '../screen/mypage/setting_screen.dart';

enum AppBarType {
  normalAppBar,
  myPageAppBar,
  homePageAppBar,
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType appBarType;

  const CommonAppBar({super.key, required this.title, required this.appBarType});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());

    return GetBuilder<ThemeController>(
        builder: (_) {
          return AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            elevation: 1.5,
            title: Text(
              title,
              style: TextStyle(
                color: themeController.selectedPrimaryColor,
              ),
            ),
            leading: appBarType == AppBarType.homePageAppBar ? IconButton(
              onPressed: () {

              },
              icon: IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: ManualScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(
                  Icons.question_mark,
                  color: themeController.selectedPrimaryColor,
                ),
              ),
            ) : Container(),
            actions: [
              appBarType == AppBarType.myPageAppBar ? IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const SettingScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(
                  Icons.settings,
                  color: themeController.selectedPrimaryColor,
                ),
              )
                  : appBarType == AppBarType.homePageAppBar ? IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CameraScreen(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: Icon(
                  Icons.watch_outlined,
                  color: themeController.selectedPrimaryColor,
                ),
              )
                  : Container(),
            ],
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: themeController.selectedPrimaryColor,
            ),
          );
        }
    );
  }
}