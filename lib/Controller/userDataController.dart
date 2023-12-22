import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final firestore = FirebaseFirestore.instance;

class UserDataController extends GetxController {
  late User user;

  static final UserDataController _instance = UserDataController._internal();

  //싱글톤 패턴
  factory UserDataController() {
    return _instance;
  }

  UserDataController._internal() {
    //컨트롤러를 처음 생성할때 유저의 정보를 받는다.
    user = FirebaseAuth.instance.currentUser!;
    print("UserDataController 인스턴스 생성!!");
  }

  late List<String> userProgramsName = []; //유저가 구독한 운동프로그램 이름들

  //firestore UserData컬렉션에 유저의 문서를 만든다.
  Future<void> makeUserDataDocument() async {
    await firestore.collection('userData').doc(user.uid).set({"programs": []});
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
    dayList.sort();
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
  }
}
