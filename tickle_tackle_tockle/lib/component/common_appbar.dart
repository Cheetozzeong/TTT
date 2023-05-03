import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../const/theme.dart';
import '../screen/mypage/setting_screen.dart';

enum AppBarType {
  normalAppBar,
  myPageAppBar,
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType appBarType;

  const CommonAppBar({super.key, required this.title, required this.appBarType});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 1.5,
      title: Text(
        title,
        style: const TextStyle(
          color: TTTPrimary1,
        ),
      ),
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
          icon: const Icon(
            Icons.settings,
            color: TTTPrimary1,
          ),
        ) : Container(),
      ],
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: TTTPrimary1,
      ),
    );
  }
}
