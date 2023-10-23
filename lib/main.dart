import 'package:cted/Page/addProgramDayPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//===================================================
import 'subscribedProgramsPage.dart';
import 'Widget/bottomBar.dart';
import 'Page/ProgramSchedule.dart';
import 'controller.dart';

void main() {
  return runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData(),
      getPages: [
        GetPage(
            name: '/',
            page: () => MyApp(),
            binding: BindingsBuilder(() {
              Get.put<BottomBarIndexController>(BottomBarIndexController());
            })),
        GetPage(name: '/ProgramSchedule', page: () => ProgramSchedule()),
        GetPage(name: '/ProgramSchdule/addProgramDayPage', page: () => AddProgramDayPage())
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
  // This widget is the root of your application.
  //BottomBarIndexController인스턴스
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CTED - Crossfit Training Every Day"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ),
        body: GetX<BottomBarIndexController>(
            builder: (_) => [
                  SubscribedProgramsPage(),
                  Text("경쟁을 보여줍니다"),
                  Text("찾기를 보여줍니다."),
                  Text("My를 보여줍니다")
                ][Get.find<BottomBarIndexController>().bottomBarIndex.value]),
        bottomNavigationBar: BottomBar());
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
