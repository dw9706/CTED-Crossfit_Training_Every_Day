import 'package:cted/screens/programSchedulePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cted/Controller/userDataController.dart';
import 'dart:convert';

import '../widgets/userProgramCard.dart';

class UserProgramsListPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  late List<String> userPrograms;

  void createDayContent() async {}
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDataController>(
      builder: (controller) => FutureBuilder(
          future: Get.find<UserDataController>().getUserProgramsName(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (controller.userProgramsName.length == 0) {
                //구독한 운동프로그램이 없으면...
                return Center(
                  child: Text('you don\'t have any program'),
                );
              } else {
                return ListView.builder(
                    itemCount: controller.userProgramsName.length,
                    itemBuilder: (context, index) {
                      return UserProgramCard(
                        title: controller.userProgramsName[index],
                        onTap: () {
                          //ProgramSchedulePage로 이동
                          Get.to(ProgramSchedulePage(), arguments: {
                            'programName': controller.userProgramsName[index]
                          });
                        },
                      );
                    });
              }
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(fontSize: 15),
                ),
              );
              //데이터를 기다리는 동안
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
