import 'package:cted/UI/Page/addProgramDayPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:animated_text_kit/animated_text_kit.dart';

//===================================================
import 'UI/Page/ProgramSchedule.dart';
import 'UI/Page/mainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData(),
      getPages: [
        GetPage(
          name: '/',
          page: () => MyApp(),
        ),
        GetPage(
          name: '/MainPage',
          page: () => MainPage(),
        ),
        GetPage(
            name: '/MainPage/ProgramSchedule', page: () => ProgramSchedule()),
        GetPage(
            name: '/MainPage/ProgramSchdule/addProgramDayPage',
            page: () => AddProgramDayPage())
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Authentication(),
    );
  }
}

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 70),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'CTED',
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                fontSize: 100,
                                fontWeight: FontWeight.w900,
                                color: Colors.black),
                            speed: const Duration(milliseconds: 500),
                          ),
                        ],
                        totalRepeatCount: 2,
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                        child: Text(
                      "Crossfit Training Every Day",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    )),
                    height: 20,
                    width: double.infinity,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: SignInScreen(
                        providers: providers,
                        actions: [
                          AuthStateChangeAction<SignedIn>((context, state) {
                            Navigator.pushReplacementNamed(context, '/profile');
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return MainPage();
          }
        });
  }
}

_themeData() {
  return ThemeData(
      scaffoldBackgroundColor: Color(0xFFEFE7DA),
      appBarTheme: AppBarTheme(
        color: Color(0xFFfafafa),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
        elevation: 0,
        foregroundColor: Colors.black,
      ));
}
