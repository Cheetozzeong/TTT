import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/controller/edit_habit_controller.dart';
import 'package:tickle_tackle_tockle/controller/page_change_controller.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import '../const/serveraddress.dart';
import '../const/theme.dart';
import '../screen/camera/camera_screen.dart';
import '../screen/mypage/menual_screen.dart';
import '../screen/mypage/setting_screen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

enum AppBarType {
  normalAppBar,
  myPageAppBar,
  homePageAppBar,
  habitEditAppBar,
}

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final AppBarType appBarType;

  CommonAppBar({super.key, required this.title, required this.appBarType});

  EditHabitController editHabitController = Get.put(EditHabitController());

  Future<http.Response> RemoveHabit (int habitId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    var url = Uri.parse('${ServerUrl}/habit/quit/$habitId');

    var response = await http.patch(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accesstoken' :  accessToken,
      },
    );
    return response;
  }

  Future<void> sendRemoveHabit(int habitId) async {

    final response = await RemoveHabit(habitId);

    var url = Uri.parse('${ServerUrl}/habit/quit/$habitId');
    print('$habitId');
    print(url);

    if (response.statusCode == 200) {
      print('삭제');
    }else if(response.statusCode == 401){
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refreshToken = pref.getString('refreshToken')!;
      String accessToken = pref.getString('accessToken')!;
      var url = Uri.parse('${ServerUrl}/habit/quit/$habitId');

      var response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'accesstoken' : accessToken,
          'refreshtoken' :  refreshToken,
        },
      );
      final headers = response.headers;
      final accesstoken = headers['accesstoken'];
      final refreshtoken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accesstoken!);
      sharedPreferences.setString('refreshToken', refreshtoken!);

    }else print('Login failed with status: ${response.statusCode}');
  }



  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Get.put(ThemeController());
    PageChangeController pageChangeController = Get.put(PageChangeController());

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
                  : appBarType == AppBarType.habitEditAppBar ? IconButton(
                onPressed: () {
                  Dialogs.materialDialog(
                    msg: '선택한 습관을 지울까요?',
                    title: '습관 삭제',
                    titleStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    color: Colors.white,
                    context: context,
                    actions: [
                      IconsOutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: '취소',
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      IconsButton(
                        onPressed: () {
                          sendRemoveHabit(editHabitController.id).then((value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            pageChangeController.rebuildPage();
                          });
                        },
                        text: '삭제하기',
                        color: Colors.red,
                        textStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: themeController.selectedPrimaryColor,
                ),
              ) :Container(),
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
