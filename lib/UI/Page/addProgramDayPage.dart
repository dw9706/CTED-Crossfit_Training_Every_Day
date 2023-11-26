import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddProgramDayPage extends StatefulWidget {
  const AddProgramDayPage({super.key});

  @override
  State<AddProgramDayPage> createState() => _AddProgramDayPageState();
}

class _AddProgramDayPageState extends State<AddProgramDayPage> {
  List<String> listItem = [];
  String? day;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  _validationDay(){
    if(day != null){
      return true;
    } else if(day == null){
      Get.snackbar("필수 정보", "Day를 선택해 주세요.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      icon:Icon(Icons.warning_amber_rounded,
      color: Colors.red,
      )
      );
      return false;
    }
  }

  getProgramsDays() async {
    var result = await firestore.collection('Programs').doc(Get.arguments['name']).collection('days').get();
    List<String> tmp = [];
    for(var doc in result.docs){
      tmp.add(doc['day']);
    }
    setState(() {
      listItem = tmp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProgramsDays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments['name']),
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios), onTap: () => Get.back()),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  '${DateFormat.yMMMMd().format(Get.arguments['date'])}',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                'Add Day',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: DropdownMenu<String>(
                    width: 350,
                    hintText: "Day",
                    onSelected: (String? value) {
                      setState(() {
                        day = value;
                        print(value);
                      });
                    },
                    dropdownMenuEntries:
                    listItem.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                  )),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_validationDay()){
                          print(day);
                          String date = Get.arguments['date'].toString().substring(0,10);
                          firestore.collection('userData').doc(user!.uid).collection('programs')
                              .doc(Get.arguments['name']).update({date: FieldValue.arrayUnion([day])}).then((_){
                            Get.offNamed('/MainPage/ProgramSchedule', arguments: {"name": Get.arguments["name"], "date": Get.arguments['date']});
                          });
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text("Add",
                            style: TextStyle(color: Colors.white,
                            ),
                          ),),
                        margin: EdgeInsets.only(right: 20),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        child: Center(child: Text("Cancel", style: TextStyle(color: Colors.white),)),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),

                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

