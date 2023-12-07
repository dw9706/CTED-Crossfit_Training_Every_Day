import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final firestore = FirebaseFirestore.instance;

class UserData with ChangeNotifier {
  UserData({required this.user});

  User user;
  late DocumentSnapshot<Map<String, dynamic>> userDataDocument;
  late List<String> userProgramsName;

  //firestore UserData컬렉션에 유저의 문서를 만든다.
  Future<void> makeUserDataDocument() async {
    await firestore.collection('userData').doc(user.uid).set({"programs": []});
  }

  //firestore의 userData컬렉션에서 user의 doc을 가져와 리턴한다.
  Future<int> getUserProgramsName() async {
    //user의 doc을 가져온다.
    DocumentSnapshot<Map<String, dynamic>> result =
        await firestore.collection('userData').doc("${user.uid}").get();
    //있으면 바로 리턴한다.
    if (result.exists) {
      userProgramsName = List<String>.from(result.data()!['programs'] as List);
      notifyListeners();
      return 0;
    } else {
      //만약 user의 doc이 없으면 doc을 만들고 리턴한다.
      await makeUserDataDocument();
      userProgramsName = [];
      notifyListeners();
      return 0;
    }
  }

  //유저 운동프로그램의 등록된 날짜를 가져온다
  Future<List<String>> getScheduleDays(
      {required String programName, required DateTime selectedDate}) async {
    String day = selectedDate.toString().substring(0, 10);
    var result = await firestore
        .collection('userData')
        .doc(user.uid)
        .collection('program Schedule')
        .doc(programName)
        .get();
    List<String> dayList = List<String>.from(result[day] as List);
    dayList.sort();
    print(dayList);
    return dayList;
  }

  Future<List<String>> howManyDays({required String programName}) async {
    var result = await firestore
        .collection('Programs')
        .doc(programName)
        .collection('days')
        .get();
    List<String> tmp = [];
    for (var doc in result.docs) {
      tmp.add(doc['day']);
    }
    return tmp;
  }
}
