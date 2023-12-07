import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/screens/userProgramsListPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // This widget is the root of your application.
  int bottomBarIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CTED - Crossfit Training Every Day"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ),
        body: [
          UserProgramsListPage(),
          Text("찾기를 보여줍니다."),
          Text("My를 보여줍니다")
        ][bottomBarIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined),
              label: '프로그램',
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
          currentIndex: bottomBarIndex,
          onTap: (value) {
            setState(() {
              bottomBarIndex = value;
            });
          },
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
        ));
  }
}
