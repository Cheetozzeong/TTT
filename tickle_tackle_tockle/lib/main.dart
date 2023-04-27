import 'package:flutter/material.dart';

//Const
import 'const/theme.dart';

//Screen
import 'package:tickle_tackle_tockle/screen/habits/CreateScreen.dart';
import 'package:tickle_tackle_tockle/screen/habits/HabitsScreen.dart';
import 'package:tickle_tackle_tockle/screen/home/HomeScreen.dart';
import 'package:tickle_tackle_tockle/screen/login/login_screen.dart';
import 'package:tickle_tackle_tockle/screen/mypage/MyPageScreen.dart';
import 'package:tickle_tackle_tockle/screen/reward/RewardScreen.dart';

//Firebase
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Widget
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '틱택톡',
        theme: ThemeData(
          primaryColor: TTTPrimary1,
          fontFamily: "Maplestory",
        ),
        home: const MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: BottomNavBar(),
          /*body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomeScreen();
              }

              return const LoginScreen();
            }
          ),*/
        ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 디바이스 사이즈 크기 정의
    final Size size = MediaQuery.of(context).size;

    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        HabitsScreen(),
        CreateScreen(),
        RewardScreen(),
        MyPageScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          activeColorPrimary: TTTPrimary1,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt),
          inactiveIcon: const Icon(Icons.list_alt),
          activeColorPrimary: TTTPrimary1,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Colors.white,),
          iconSize: size.height * 0.06,
          inactiveIcon: const Icon(Icons.add, color: Colors.white,),
          activeColorPrimary: TTTPrimary1,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.star),
          inactiveIcon: const Icon(Icons.star),
          activeColorPrimary: TTTPrimary1,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          activeColorPrimary: TTTPrimary1,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('틱택톡'),
      ),
      body: PersistentTabView(
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
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
        navBarHeight: size.height * 0.09,
      ),
    );
  }
}