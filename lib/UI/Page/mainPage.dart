import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/UI/Page/subscribedProgramsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyAppState();
}

class _MyAppState extends State<MainPage> {
  // This widget is the root of your application.
  int bottomBarIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  _setBottomBarIndex(value) {
    setState(() {
      bottomBarIndex = value;
    });
  }

  Future<bool> checkUserData(String userId) async {

    DocumentSnapshot<Map<String, dynamic>> document = await firestore.collection('userData').doc(userId).get();
    if (!document.exists) {
      return true;
    } else {
      return false;
    }
  }

  void makeUserData() async {

    bool tmp = await checkUserData("${user!.uid}");
    if (tmp) {
      await firestore.collection('userData').doc(user!.uid).set({"uid":user!.uid});
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeUserData();
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
          SubscribedProgramsPage(user: user, firestore: firestore),
          Text("경쟁을 보여줍니다"),
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
          currentIndex: bottomBarIndex,
          onTap: _setBottomBarIndex,
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
        ));
  }
}

