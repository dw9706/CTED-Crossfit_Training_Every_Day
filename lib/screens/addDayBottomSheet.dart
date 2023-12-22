import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cted/Controller/programsDataController.dart';
import 'package:cted/Controller/userDataController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDayBottomSheet extends StatefulWidget {
  AddDayBottomSheet({required this.programName, required this.date});
  String programName;
  DateTime date;

  @override
  State<AddDayBottomSheet> createState() => _AddDayBottomSheetState();
}

class _AddDayBottomSheetState extends State<AddDayBottomSheet> {
  String? day;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  _validationDay() {
    if (day != null) {
      print(day);
      return true;
    } else if (day == null) {
      print(day);
      return false;
    }
  }

  @override
  Widget build(context) {
    return FutureBuilder(
        future: Get.find<ProgramsDataController>()
            .howManyDays(programName: widget.programName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //day 선택하는 드롭다운메뉴
                Center(
                  child: DropdownMenu<String>(
                    width: 300,
                    hintText: "Day",
                    onSelected: (String? value) {
                      setState(() {
                        day = value;
                      });
                    },
                    dropdownMenuEntries: snapshot.data!
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry(value: value, label: value);
                    }).toList(),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Add버튼
                    GestureDetector(
                      onTap: () {
                        if (_validationDay()) {
                          Get.find<UserDataController>().updateScheduleDays(
                              date: widget.date,
                              programName: widget.programName,
                              day: day!);
                        } else {
                          //Day를 정하지 않고 Add를 누르면 SnackBar나옴
                          Get.snackbar("필수 정보", "Day를 선택해 주세요.",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                              ));
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    //Cancel버튼
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
