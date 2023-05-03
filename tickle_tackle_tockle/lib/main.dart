import 'package:flutter/material.dart';
import 'const/theme.dart';
import 'component/main_fram.dart';
import 'controller/loading_controller.dart';
import 'package:tickle_tackle_tockle/screen/login/login_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  sendIdToken() async {
    String str = await FirebaseAuth.instance.currentUser!.getIdToken();
    //print(str);
  }

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());

    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // ID Token 확인
                      sendIdToken();

                      return const MainFrame();
                    }

                    return const LoginScreen();
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
                                  return const DecoratedBox(
                                    decoration: BoxDecoration(color: TTTPrimary1),
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