import 'package:cted/UI/Page/subscribedProgramsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/bottomIndex_controller.dart';
import '../Widget/bottomBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyAppState();
}

class _MyAppState extends State<MainPage> {
  // This widget is the root of your application.
  //BottomBarIndexController인스턴스
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CTED - Crossfit Training Every Day"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {FirebaseAuth.instance.signOut();},
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

