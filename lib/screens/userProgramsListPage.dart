import 'package:cted/screens/programSchedulePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cted/models/userData.dart';
import 'dart:convert';

import '../widgets/userProgramCard.dart';

class UserProgramsListPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  late List<String> userPrograms;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<UserData>(context).getUserProgramsName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (Provider.of<UserData>(context).userProgramsName.length == 0) {
              //구독한 운동프로그램이 없으면...
              return Center(
                child: Text('you don\'t have any program'),
              );
            } else {
              return ListView.builder(
                  itemCount:
                      Provider.of<UserData>(context).userProgramsName.length,
                  itemBuilder: (context, index) {
                    return UserProgramCard(
                      title: Provider.of<UserData>(context)
                          .userProgramsName[index],
                      onTap: () {
                        String tmp =
                            Provider.of<UserData>(context, listen: false)
                                .userProgramsName[index];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider.value(
                              value: UserData(user: user!),
                              child: ProgramSchedulePage(programName: tmp),
                            ),
                          ),
                        );
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
        });
  }
}
