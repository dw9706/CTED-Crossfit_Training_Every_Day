import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/screens/searchProgramPage.dart';
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
  //FileManager fileManager = FileManager();
  int bottomBarIndex = 0;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "CTED - Crossfit Training Every Day",
            style: TextStyle(fontSize: 18),
          ),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ),
        body: [
          UserProgramsListPage(),
          SearchProgramPage(), //Test
          Text('마이페이지') //Test
        ][bottomBarIndex],
        // BottomBar
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

class TestWidget extends StatefulWidget {
  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  String tmp = '';
  String day = '';
  final fieldText = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  //FileManager fileManager = FileManager();
  bool _showCircle = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await firestore
              .collection('programsData')
              .doc('Power lifting(kdw)')
              .collection('days')
              .doc('day $day')
              .set({'content': tmp});
          fieldText.clear();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                day = value;
              },
            ),
            TextField(
              controller: fieldText,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (value) {
                tmp = value;
                print(tmp);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShowText extends StatelessWidget {
  //FileManager fileManager = FileManager();
  getFilecontent() async {
    //return await fileManager.readTextFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getFilecontent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String content = snapshot.data.toString();
              return SingleChildScrollView(
                child: Text(
                  content,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                scrollDirection: Axis.vertical,
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
