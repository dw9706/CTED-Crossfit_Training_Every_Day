import 'package:cted/screens/programSchedulePage.dart';
import 'package:cted/widgets/subscribedProgramsDeleteDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cted/Controller/userDataController.dart';

class UserProgramsListPage extends StatefulWidget {
  @override
  State<UserProgramsListPage> createState() => _UserProgramsListPageState();
}

class _UserProgramsListPageState extends State<UserProgramsListPage> {
  final user = FirebaseAuth.instance.currentUser;

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.find<UserDataController>().getUserProgramsName(),
        builder: (context, snapshot) {
          return GetBuilder<UserDataController>(builder: (controller) {
            if (snapshot.hasData) {
              List<String> userProgramsName = snapshot.data!;
              if (userProgramsName.length == 0) {
                //구독한 운동프로그램이 없으면...
                return Center(
                  child: Text('you don\'t have any program'),
                );
              } else {
                return ListView.builder(
                    itemCount: userProgramsName.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => ProgramSchedulePage(), arguments: {
                            'programName': userProgramsName[index]
                          });
                        },
                        child: SizedBox(
                          height: 120,
                          child: Card(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            elevation: 2,
                            color: Colors.black,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 5, right: 5),
                                  //delete 아이콘있는 부분
                                  child: GestureDetector(
                                    onTap: () {
                                      //Program delete dialog창 띄우기
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return SubscribedProgramsDeleteDialog(
                                                programName:
                                                    userProgramsName[index]);
                                          }).then((_) {
                                        setState(() {});
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                //구독프로그램 있는 부분
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 20, right: 10),
                                  child: Text(
                                    '${userProgramsName[index]}',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
          });
        });
  }
}
