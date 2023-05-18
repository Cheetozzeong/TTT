import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickle_tackle_tockle/controller/theme_controller.dart';
import 'const/serveraddress.dart';
import 'const/theme.dart';
import 'component/main_fram.dart';
import 'controller/loading_controller.dart';
import 'package:tickle_tackle_tockle/screen/login/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

import 'model/LoginReq.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDateFormatting();

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

  getSharedPreferenceThemeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ThemeController themeController = Get.put(ThemeController());
    themeController.selectedPrimaryColor = Color(prefs.getInt('themeColor') ?? TTTPrimary1.value);
    prefs.setInt('themeColor', themeController.selectedPrimaryColor.value);

    themeController.refreshTheme();
  }

  Future<int> saveIdToken() async {
    String str = await FirebaseAuth.instance.currentUser!.getIdToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('idToken', str!);
    await checkIdToken();
    await postDeviceToken();
    return 0;
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

  Future<void> checkIdToken() async {
    final response = await sendIdToken();
    if (response.statusCode == 200) {
      final headers = response.headers;
      final accessToken = headers['accesstoken'];
      final refreshToken = headers['refreshtoken'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('accessToken', accessToken!);
      sharedPreferences.setString('refreshToken', refreshToken!);
    } else {
      print('Login failed with status: ${response.statusCode}');
    }
  }

  Future<http.Response> checkDeviceTokenRequest() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String accessToken = pref.getString('accessToken')!;
    String deviceToken = pref.getString('deviceToken')!;
    var url = Uri.parse('${ServerUrl}/fcmtoken');
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },
      body: jsonEncode(<String, String>{
        'fcmToken': deviceToken,
      }),
    );
    return response;
  }

  Future<void> postDeviceToken() async {
    final response = await checkDeviceTokenRequest().catchError((error) {
      print('postDeviceToken Error + $error');
    });

    if (response.statusCode == 200) {
      print('Token send successFully: ${response.statusCode}');
    } else {
      print('Device Token send failed with status: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    ThemeController themeController = Get.put(ThemeController());

    getSharedPreferenceThemeData();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FutureBuilder(
                      future: saveIdToken(),
                      builder: (context, snapshot) {
                        if(!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if(snapshot.hasError) {
                          return Container();
                        }

                        return const MainFrame();
                      },
                    );
                  }

                  return LoginScreen();
                }
            ),
            GetBuilder<LoadingController>(
                builder: (_) {
                  return Offstage(
                    offstage: !loadingController.isLoadingFlag,
                    child: Stack(
                      children: [
                        const Opacity(
                          opacity: 0.5,
                          child: ModalBarrier(
                            dismissible: false,
                            color: Colors.black,
                          ),
                        ),
                        Center(
                          child: SpinKitCubeGrid(
                            itemBuilder: (context, index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(color: themeController.selectedPrimaryColor),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}