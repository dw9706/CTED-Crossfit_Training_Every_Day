import 'package:flutter/material.dart';
import 'package:get/get.dart';

//=========================================================
import '../controller.dart';

class BottomBar extends StatefulWidget {
  BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return GetX<BottomBarIndexController>(
        builder: (_) => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center_outlined),
                  label: '프로그램',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events_outlined),
                  label: '경쟁',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: '찾기',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'MY',
                ),
              ],
              currentIndex:
                  Get.find<BottomBarIndexController>().bottomBarIndex.value,
              onTap: Get.find<BottomBarIndexController>().setBottomBarIndex,
              selectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
            ));
  }
}
