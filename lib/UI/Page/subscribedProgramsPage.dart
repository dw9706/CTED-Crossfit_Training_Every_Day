import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SubscribedProgramsPage extends StatefulWidget {
  SubscribedProgramsPage({super.key, required this.user, required this.firestore});
  final user;
  final firestore;
  @override
  State<SubscribedProgramsPage> createState() => _SubscribedProgramsPageState();
}

class _SubscribedProgramsPageState extends State<SubscribedProgramsPage> {

  var programsName;

  getProgramsNameFutureList() async {
    List<String> tmp = [];
    var result = await widget.firestore.collection('userData').doc(widget.user!.uid.toString()).collection('programs').get();
    for(var doc in result.docs){
      tmp.add(doc['name']);
    }
    if(tmp.isNotEmpty){
      return tmp;
    }
    return "Empty";
  }

  getProgramsName() async { //Future를 일반 List로 변환
    var tmpList = await getProgramsNameFutureList();
    setState(() {
      programsName = tmpList;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProgramsName();
  }

  @override
  Widget build (BuildContext context) {
    if(programsName == "Empty"){
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
                Get.toNamed('/MainPage/ProgramSchedule',
                    arguments: {"name": programsName[index]}); //객체도 보낼수 있음!
              },
              child: Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    //border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  programsName[index],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400
                  ),
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