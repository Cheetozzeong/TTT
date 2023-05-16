import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/component/a804_screen.dart';
import '../const/theme.dart';
import '../controller/theme_controller.dart';
import '../screen/create/category_screen.dart';
import '../screen/create/create_screen.dart';
import '../screen/habits/habits_screen.dart';
import '../screen/home/home_screen.dart';
import '../screen/mypage/mypage_screen.dart';
import '../screen/reward/reward_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';


class MainFrame extends StatelessWidget {
  const MainFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    ThemeController themeController = Get.put(ThemeController());

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        HabitsScreen(),
        A804Screen(),
        CreateScreen(),
        RewardScreen(),
        MyPageScreen(mainContext: context,),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          activeColorPrimary: themeController.selectedPrimaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt),
          inactiveIcon: const Icon(Icons.list_alt),
          activeColorPrimary: themeController.selectedPrimaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Colors.white,),
          iconSize: size.height * 0.06,
          inactiveIcon: const Icon(Icons.add, color: Colors.white,),
          activeColorPrimary: themeController.selectedPrimaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Ionicons.trophy_outline),
          inactiveIcon: const Icon(Ionicons.trophy_outline),
          activeColorPrimary: themeController.selectedPrimaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          activeColorPrimary: themeController.selectedPrimaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController _controller = PersistentTabController(initialIndex: 0);

    return GetBuilder<ThemeController>(
      builder: (_) {
        return Scaffold(
          body: Stack(
            children: [
              PersistentTabView(
                context,
                controller: _controller,
                screens: _buildScreens(),
                items: _navBarsItems(),
                confineInSafeArea: true,
                backgroundColor: Colors.white, // Default is Colors.white.
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: NavBarDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  colorBehindNavBar: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 5.0)
                  ],
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 10),
                    curve: Curves.bounceIn
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  curve: Curves.bounceIn,
                  duration: Duration(milliseconds: 10),
                ),
                navBarStyle: NavBarStyle.style14, // Choose the nav bar style with this property.
                navBarHeight: size.height * 0.09,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: deviceHeight * 0.04),
                  child: SizedBox(
                    width: deviceHeight * 0.09,
                    height: deviceHeight * 0.09,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const CategoryScreen(),
                            withNavBar: false,
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                        },
                        backgroundColor: themeController.selectedPrimaryColor,
                        elevation: 2,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

