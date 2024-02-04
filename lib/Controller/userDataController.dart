import 'package:cted/Controller/programsDataController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;

class UserDataController extends GetxController {
  UserDataController({required this.user}) {
    print('${user.uid}');
  }
  User user;

  late List<String> userProgramsName = []; //유저가 구독한 운동프로그램 이름들

  //firestore UserData컬렉션에 유저의 문서를 만든다.
  Future<void> makeUserDataDocument() async {
    await firestore.collection('userData').doc(user.uid).set(
        {"programs": [], "name": 'Null', "sex": "Null", "country": "Null"});
  }

  //firestore의 userData컬렉션에서 user의 doc을 가져와 리턴한다.
  Future<List<String>> getUserProgramsName() async {
    //user의 doc을 가져온다.
    DocumentSnapshot<Map<String, dynamic>> result =
        await firestore.collection('userData').doc("${user.uid}").get();
    //있으면 바로 리턴한다.
    if (result.exists) {
      //변수에 대입
      userProgramsName = List<String>.from(result['programs'] as List);
      update();
      return userProgramsName;
    } else {
      //만약 user의 doc이 없으면 doc을 만들고 리턴한다.
      await makeUserDataDocument();
      userProgramsName = [];
      update();
      return userProgramsName;
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
    List<int> dayListFotInt = [];
    for (int i = 0; i < dayList.length; i++) {
      //day 12에서 숫자만 잘라서 다시 넣는다.
      dayListFotInt.add(int.parse(dayList[i].substring(4)));
    }
    dayListFotInt.sort();

    for (int i = 0; i < dayList.length; i++) {
      dayList[i] = 'day ${dayListFotInt[i]}';
    }
    print(dayList);
    return dayList;
  }

  //selected 날짜에 운동프로그램 day를 등록한다.
  Future<void> updateScheduleDays(
      {required DateTime selectedDate,
      required String programName,
      required String day}) async {
    String fomatDate = selectedDate.toString().substring(0, 10);
    await firestore
        .collection('userData')
        .doc(user!.uid)
        .collection('program Schedule')
        .doc(programName)
        .update({
      fomatDate: FieldValue.arrayUnion(
          [day]) //FieldValue : 해당 필드데이터, arrayUnion() : 배열에 없는 요소만 추가
    });
  }

  //선택한 day를 삭제한다.
  Future<void> deleteScheduleDays(
      {required DateTime selectedDate,
      required String programName,
      required String day}) async {
    String fomatDate = selectedDate.toString().substring(0, 10);

    await firestore
        .collection('userData')
        .doc(user!.uid)
        .collection('program Schedule')
        .doc(programName)
        .update({
      fomatDate: FieldValue.arrayRemove(
          [day]) //FieldValue : 해당 필드데이터, arrayRemove(): 제공된 각 요소의 모든 인스턴스를 삭제
    });
  }

  //구독한 운동프로그램을 삭제한다.
  Future<void> deleteSubscribedProgram({required String programName}) async {
    //유저아이디 문서의 programs필드에서 프로그램이름을 지운다.
    await firestore.collection('userData').doc(user!.uid).update({
      'programs': FieldValue.arrayRemove([programName])
    });

    //program Schedule 컬렉션에서 프로그램이름으로 된 문서를 지운다.
    await firestore
        .collection('userData')
        .doc(user!.uid)
        .collection('program Schedule')
        .doc(programName)
        .delete();

    await Get.find<ProgramsDataController>()
        .minusProgramFollowers(programName: programName);
  }

  Future<bool> checkThisProgramSubcribed({required String programName}) async {
    var result = await firestore.collection('userData').doc(user!.uid).get();
    //프로그램이름이 있으면 true, 없으면 false를 반환
    return result.data()!['programs'].contains(programName);
  }

  Future<void> subscribeProgram({required String programName}) async {
    //programs필드에 프로그램이름 추가
    await firestore.collection('userData').doc(user!.uid).update({
      'programs': FieldValue.arrayUnion(["$programName"]),
    });
    //program Schedule 컬렉션에 문서 추가
    await firestore
        .collection('userData')
        .doc(user!.uid)
        .collection('program Schedule')
        .doc(programName)
        .set({});
    //프로그램의 팔로워를 하나 올린다.
    await Get.find<ProgramsDataController>()
        .plusProgramFollowers(programName: programName);
  }

  Future<List<String>> getUserData() async {
    var tmp = await firestore.collection('userData').doc(user!.uid).get();
    List<String> result = [];
    result.add(tmp['name']);
    result.add(tmp['sex']);
    result.add(tmp['country']);
    return result;
  }

  Future<void> updateUserData(
      {required String fieldName, required String fieldData}) async {
    await firestore
        .collection('userData')
        .doc(user!.uid)
        .update({fieldName: fieldData});
  }
}
