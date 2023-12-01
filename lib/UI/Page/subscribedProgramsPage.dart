import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SubscribedProgramsPage extends StatefulWidget {
  SubscribedProgramsPage(
      {super.key, required this.user, required this.firestore});
  final user;
  final firestore;
  @override
  State<SubscribedProgramsPage> createState() => _SubscribedProgramsPageState();
}

class _SubscribedProgramsPageState extends State<SubscribedProgramsPage> {
  var programsName;
  bool updateState = true;
  getProgramsNameFutureList() async {
    List<String> tmp = [];
    var result = await widget.firestore
        .collection('userData')
        .doc(widget.user!.uid)
        .get();
    if (result.exists) {
      for (var doc in result['programs']) {
        tmp.add(doc);
      }
      print(tmp);
      if (tmp.isNotEmpty) {
        return tmp;
      }
      return "Empty";
    } else {
      return Future.delayed(Duration(seconds: 5), () async {
        result = await widget.firestore
            .collection('userData')
            .doc(widget.user!.uid)
            .get();
        for (var doc in result['programs']) {
          tmp.add(doc);
        }
        print(tmp);
        if (tmp.isNotEmpty) {
          return tmp;
        }
        return "Empty";
      });
    }
  }

  getProgramsName() async {
    //Future<List<String>> -> List<String>
    var tmpList = await getProgramsNameFutureList();
    setState(() {
      programsName = tmpList;
    });
  }

  @override
  void initState() {
    // TODO: implement init State
    super.initState();
    getProgramsName();
  }

  @override
  Widget build(BuildContext context) {
    if (programsName == "Empty") {
      return Center(
        child: Container(
          child: Text('you don\'t have any program',
              style: TextStyle(color: Colors.grey)),
        ),
      );
    } else if (programsName != null) {
      return ListView.builder(
        itemCount: programsName.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/MainPage/ProgramSchedule', arguments: {
                "name": programsName[index],
                "date": DateTime.now()
              }); //객체도 보낼수 있음!
            },
            child: Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  //border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                programsName[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
