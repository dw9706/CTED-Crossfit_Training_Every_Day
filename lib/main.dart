import 'package:cted/UI/Page/addProgramDayPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

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
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SignInScreen(
              providerConfigs: [EmailProviderConfiguration()],
            );
          } else {
            return MainPage();
          }
        });
  }
}

_themeData() {
  return ThemeData(
      appBarTheme: AppBarTheme(
    color: Color(0xFFfafafa),
    titleTextStyle: TextStyle(
        color: Colors.black, fontSize: 19, fontWeight: FontWeight.w600),
    elevation: 0,
    foregroundColor: Colors.black,
  ));
}
